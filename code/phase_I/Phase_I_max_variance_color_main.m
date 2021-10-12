clear;
%%
%% for bx.jpg
m = 150;
v = [];


for i=1:35
    a = imread(sprintf('g%d.png',i));
    % transform the sample image from rgb to hsv
    hsvImage = rgb2hsv(a);
    % modify the hue value of the image
    hsvImage(:,:,1) = rem(hsvImage(:,:,1) * 1.6, 1);
    % transform hsv to rgb
    rgbImage = hsv2rgb(hsvImage);
    % extract the maximum variance
    variance_single =max_variance_of_colorpic(rgbImage);
    v = [v,variance_single];
    
end



for i=1:115
    if i<10
        a = imread(sprintf('image_part_00%d.jpg',i));
        hsvImage = rgb2hsv(a);
        hsvImage(:,:,1) = rem(hsvImage(:,:,1) * 1.6, 1);
        rgbImage = hsv2rgb(hsvImage);
        variance_single =max_variance_of_colorpic(rgbImage);
        v = [v,variance_single];
    elseif i>=10 && i <100 
        a = imread(sprintf('image_part_0%d.jpg',i));
        hsvImage = rgb2hsv(a);
        hsvImage(:,:,1) = rem(hsvImage(:,:,1) * 1.6, 1);
        rgbImage = hsv2rgb(hsvImage);
        variance_single =max_variance_of_colorpic(rgbImage);
        v = [v,variance_single];
    else
        a = imread(sprintf('image_part_%d.jpg',i));
        hsvImage = rgb2hsv(a);
        hsvImage(:,:,1) = rem(hsvImage(:,:,1) * 1.6, 1);
        rgbImage = hsv2rgb(hsvImage);
        variance_single =max_variance_of_colorpic(rgbImage);
        v = [v,variance_single];
    end


end

%calculate the mean
mean_variance_of_good_slide  = mean(v);

% calculate the sigma_s of sample to finally determine the UCL
% see Equation (4.1) - (4.4) in Studienarbeit
v_sum = 0;
for k = 1:m
    v_sum = v_sum + (v(k) - mean_variance_of_good_slide)^2;
end
s = sqrt(v_sum/m);
nn = m/2 -1;
fac_48 = 1;
for q = 0:nn-1
    fac_48 = fac_48 * (nn-0.5 -q);
end
fac_48 = fac_48 * sqrt(pi);
fac_49 = factorial(m/2-1);
c_4 = sqrt(2/(m-1)) * fac_49/fac_48;

sigma_s = s/c_4 * sqrt(1-c_4^2);
UCL = mean_variance_of_good_slide + 3* sigma_s;
LCL = mean_variance_of_good_slide - 3* sigma_s;

% calculate the number of false alarm in Phase I 
false_alarm = 0;
for j = 1:m
    if v(j)>UCL
         false_alarm = false_alarm+1;
    end
end

% plot control chart result
x=[1:1:m];
x1 = [1:1:m];
y2 = UCL*ones([1,m]);
y3 = 49.22*ones([1,m]);

v_log = log2(v);
y2_log = log2(y2);

plot(x,v_log,x1,y2_log);
text(136,log2(UCL),'UCL')
    p = false_alarm/m;
    average_run_length = 1/p;
%plot(x,v,x1,y2);
title("Phase II color changed image maximum variance statistic")
xlabel("image number")
ylabel("log2(maximum variance statistic)")