
%% for bx.jpg
clear;
load t2_color_150_1.mat;
m = 85;
UCL = 8.157;
total_sample = 85;
bad_num = 40;
test_result = [];
for i=1:bad_num
    a = imread(sprintf('b%d.jpg',i));
    hsvImage = rgb2hsv(a);
    hsvImage(:,:,1) = rem(hsvImage(:,:,1) * 1.6, 1);
    rgbImage = hsv2rgb(hsvImage);
    [r,g,b]=haar2_wavelet_color(rgbImage);
    X_bar = [r,g,b];
    T2 =  ([X_bar - X_double_bar] * inv(covariance) *[X_bar - X_double_bar].' );
    test_result = [test_result,T2];
end

for i=1:34
        a = imread(sprintf('g%d.png',i));
        hsvImage = rgb2hsv(a);
        hsvImage(:,:,1) = rem(hsvImage(:,:,1) * 1.6, 1);
        rgbImage = hsv2rgb(hsvImage);
        [r,g,b]=haar2_wavelet_color(rgbImage);
        X_bar = [r,g,b];
        T2 =  ([X_bar - X_double_bar] * inv(covariance) *[X_bar - X_double_bar].' );
        test_result = [test_result,T2];
end

for i=25:35
        a = imread(sprintf('image_part_0%d.jpg',i));
        hsvImage = rgb2hsv(a);
        hsvImage(:,:,1) = rem(hsvImage(:,:,1) * 1.6, 1);
        rgbImage = hsv2rgb(hsvImage);
        [r,g,b]=haar2_wavelet_color(rgbImage);
        X_bar = [r,g,b];
        T2 =  ([X_bar - X_double_bar] * inv(covariance) *[X_bar - X_double_bar].' );
        test_result = [test_result,T2];
end


% 
% for i=1:97
%     if i<10
%         
%         a = imread(sprintf('image_part_00%d.jpg',i));
%         hsvImage = rgb2hsv(a);
%         hsvImage(:,:,1) = rem(hsvImage(:,:,1) * 1.6, 1);
%         rgbImage = hsv2rgb(hsvImage);
%         [r,g,b]=haar2_wavelet(rgbImage);
%         
%         X_bar = [r,g,b];
%         T2 =  ([X_bar - X_double_bar] * inv(covariance) *[X_bar - X_double_bar].' );
%         test_result = [test_result,T2];
%     else
%         a = imread(sprintf('image_part_0%d.jpg',i));
%         hsvImage = rgb2hsv(a);
%         hsvImage(:,:,1) = rem(hsvImage(:,:,1) * 1.6, 1);
%         rgbImage = hsv2rgb(hsvImage);
%         [r,g,b]=haar2_wavelet(rgbImage);
%         X_bar = [r,g,b];
%         T2 =  ([X_bar - X_double_bar] * inv(covariance) *[X_bar - X_double_bar].' );
%         test_result = [test_result,T2];
%     end
% 
% end
% haar2_wavelet using 3d has 22 false alarm
% haar2_wavelet using hdv has 13 false alarm
false_alarm = 0;
for j = 1:m
    if j<=bad_num && test_result(j)<UCL
        false_alarm = false_alarm+1;
    else if j>bad_num && test_result(j)>UCL
         false_alarm = false_alarm+1;
    end
    end
end
    
v_log = log2(test_result);


x=[1:1:m];
x1 = [1:1:m];
x2 = UCL*ones([1,m]);
x2_log = log2(x2);
%plot(x,test_result,x1,x2);
% plot log2
plot(x,v_log,x1,x2_log);
text(60,log2(UCL),'UCL')
% title("Phase II color_changed_image statistic(orange line is UCL = 8.276)")
title("Phase II color changed image statistic")
xlabel("image number")
% ylabel("T2 statistic")
ylabel("log2(T2 statistic)")