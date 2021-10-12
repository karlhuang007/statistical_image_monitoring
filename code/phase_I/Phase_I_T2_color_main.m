clear;
X_bar_set = [];
cov_set = [];
test_result = [];
p=3;
m = 150;
F_distribusion = 2.665;
UCL = (p * (m+1)*(m-1) / (m*m - m*p)) * F_distribusion;
% calculate every normal image's covariance matrix and mean vector    
for i=1:35
    a = imread(sprintf('g%d.png',i));
    % transform the sample image from rgb to hsv
    hsvImage = rgb2hsv(a);
    % modify the hue value of the image
    hsvImage(:,:,1) = rem(hsvImage(:,:,1) * 1.6, 1);
    % transform hsv to rgb
    rgbImage = hsv2rgb(hsvImage);
    % extract the maximum variance
    [r,g,b]=haar2_wavelet_color(rgbImage);
    X_bar_set = [X_bar_set;r,g,b];
    
end

for i=1:115
    if i<10
        %[r,g,b]=haar2_wavelet(sprintf('image_part_00%d.jpg',i));
        a = imread(sprintf('image_part_00%d.jpg',i));
        hsvImage = rgb2hsv(a);
        hsvImage(:,:,1) = rem(hsvImage(:,:,1) * 1.6, 1);
        rgbImage = hsv2rgb(hsvImage);
        [r,g,b]=haar2_wavelet_color(rgbImage);
    elseif i>=10 && i <100
        %[r,g,b]=haar2_wavelet(sprintf('image_part_0%d.jpg',i));
        a = imread(sprintf('image_part_0%d.jpg',i));
        hsvImage = rgb2hsv(a);
        hsvImage(:,:,1) = rem(hsvImage(:,:,1) * 1.6, 1);
        rgbImage = hsv2rgb(hsvImage);
        [r,g,b]=haar2_wavelet_color(rgbImage);
    else
        a = imread(sprintf('image_part_%d.jpg',i));
        hsvImage = rgb2hsv(a);
        hsvImage(:,:,1) = rem(hsvImage(:,:,1) * 1.6, 1);
        rgbImage = hsv2rgb(hsvImage);
        [r,g,b]=haar2_wavelet_color(rgbImage);
    end
    X_bar_set = [X_bar_set;r,g,b];

end


X_double_bar = mean(X_bar_set);
[m,n] = size(X_bar_set);

% calculate the covariance matrix of sample
for i = 1:3
    for j = 1:3
        num = 0.0;
        if i==j
            covariance1(i,j) = var(X_bar_set(:,i));
        else
            
            for k = 1: m
                a = X_bar_set(k,i) - X_double_bar(i);
                b = X_bar_set(k,j) - X_double_bar(j);
%                 num = num + ((X_bar_set(m,i) - X_double_bar(i)) * (X_bar_set(m,j) - X_double_bar(j)));
                num = num + a*b;
            end
            covariance1(i,j) =  num/(m-1);
        end
    end
end
covariance = cov(X_bar_set);


% apply the aboved calculate parameter X_double_bar and covariance into
% same samples to calculate the average run length
for i=1:35
    a = imread(sprintf('g%d.png',i));
    hsvImage = rgb2hsv(a);
    hsvImage(:,:,1) = rem(hsvImage(:,:,1) * 1.6, 1);
    rgbImage = hsv2rgb(hsvImage);
    [r,g,b]=haar2_wavelet_color(rgbImage);
    X_bar = [r,g,b];
    T2 =  ([X_bar - X_double_bar] * inv(covariance) *[X_bar - X_double_bar].' );
    test_result = [test_result,T2];
end

 
for i=1:115
    if i<10
        a = imread(sprintf('image_part_00%d.jpg',i));
        hsvImage = rgb2hsv(a);
        hsvImage(:,:,1) = rem(hsvImage(:,:,1) * 1.6, 1);
        rgbImage = hsv2rgb(hsvImage);
        [r,g,b]=haar2_wavelet_color(rgbImage);
        
        X_bar = [r,g,b];
        T2 =  ([X_bar - X_double_bar] * inv(covariance) *[X_bar - X_double_bar].' );
        test_result = [test_result,T2];
    elseif i>=10 && i <100 
        a = imread(sprintf('image_part_0%d.jpg',i));
        hsvImage = rgb2hsv(a);
        hsvImage(:,:,1) = rem(hsvImage(:,:,1) * 1.6, 1);
        rgbImage = hsv2rgb(hsvImage);
        [r,g,b]=haar2_wavelet_color(rgbImage);
        X_bar = [r,g,b];
        T2 =  ([X_bar - X_double_bar] * inv(covariance) *[X_bar - X_double_bar].' );
        test_result = [test_result,T2];
    else
        a = imread(sprintf('image_part_%d.jpg',i));
        hsvImage = rgb2hsv(a);
        hsvImage(:,:,1) = rem(hsvImage(:,:,1) * 1.6, 1);
        rgbImage = hsv2rgb(hsvImage);
        [r,g,b]=haar2_wavelet_color(rgbImage);
        X_bar = [r,g,b];
        T2 =  ([X_bar - X_double_bar] * inv(covariance) *[X_bar - X_double_bar].' );
        test_result = [test_result,T2];

    end

end
x=[1:1:m];
x1 = [1:1:m];
x2 = UCL*ones([1,m]);



% calculate the number of false alarm
bad_sample_index = [];
false_alarm = 0;
for j = 1:m
    if test_result(j)>UCL
        false_alarm = false_alarm+1;
        if j<=35
            bad_sample_index = [bad_sample_index,j];
        else
            bad_sample_index = [bad_sample_index,j-22];
        end
    end
end
% p denoting the probability of an observation plotting outside the control limits.
 p = false_alarm/m;
average_run_length = 1/p;

% caluclate log2(result)
v_log = log2(test_result);
x2_log = log2(x2);

%   plot(x,test_result,x1,x2);
  plot(x,v_log,x1,x2_log);
  text(120,log2(UCL),'UCL')

% title("Phase II image Hotelling T2 statistic(orange line is UCL = 8.276)")
title("Phase I change color image Hotelling T2 statistic")
xlabel("image number")
 ylabel("log2(T2 statistic)")
%  ylabel("T2 statistic")
save('t2_color_150_1.mat','X_double_bar','covariance');
    p = false_alarm/m;
    average_run_length = 1/p;
