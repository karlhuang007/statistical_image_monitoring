%% for bx.jpg
load cov_x_color.mat;
test_result = [];
for i=1:23
    a = imread(sprintf('b%d.jpg',i));
    hsvImage = rgb2hsv(a);
    hsvImage(:,:,1) = rem(hsvImage(:,:,1) * 1.6, 1);
    rgbImage = hsv2rgb(hsvImage);
    [r,g,b]=haar2_wavelet(rgbImage);
    X_bar = [r,g,b];
    T2 =  ([X_bar - X_double_bar] * inv(covariance) *[X_bar - X_double_bar].' );
    test_result = [test_result,T2];
end



for i=1:97
    if i<10
        
        a = imread(sprintf('image_part_00%d.jpg',i));
        hsvImage = rgb2hsv(a);
        hsvImage(:,:,1) = rem(hsvImage(:,:,1) * 1.6, 1);
        rgbImage = hsv2rgb(hsvImage);
        [r,g,b]=haar2_wavelet(rgbImage);
        
        X_bar = [r,g,b];
        T2 =  ([X_bar - X_double_bar] * inv(covariance) *[X_bar - X_double_bar].' );
        test_result = [test_result,T2];
    else
        a = imread(sprintf('image_part_0%d.jpg',i));
        hsvImage = rgb2hsv(a);
        hsvImage(:,:,1) = rem(hsvImage(:,:,1) * 1.6, 1);
        rgbImage = hsv2rgb(hsvImage);
        [r,g,b]=haar2_wavelet(rgbImage);
        X_bar = [r,g,b];
        T2 =  ([X_bar - X_double_bar] * inv(covariance) *[X_bar - X_double_bar].' );
        test_result = [test_result,T2];
    end

end
% haar2_wavelet using 3d has 22 false alarm
% haar2_wavelet using hdv has 13 false alarm
false_alarm = 0;
for j = 1:120
    if j<=46 && test_result(j)<8.276
        false_alarm = false_alarm+1;
    if j>46 && test_result(j)>8.276
         false_alarm = false_alarm+1;
    end
    end
end
    
v_log = log2(test_result);


x=[1:1:120];
x1 = [1:1:120];
x2 = 8.276*ones([1,120]);
x2_log = log2(x2);
%plot(x,test_result,x1,x2);
% plot log2
plot(x,v_log,x1,x2_log);
% title("Phase II color_changed_image statistic(orange line is UCL = 8.276)")
title("Phase II color changed image statistic(orange line is UCL)")
xlabel("image number")
% ylabel("T2 statistic")
ylabel("log2(T2 statistic)")