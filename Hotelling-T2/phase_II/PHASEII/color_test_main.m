%% for bx.jpg
load cov_x_color.mat;
test_result = [];
for i=1:22
    a = imread(sprintf('b%d.jpg',i));
    hsvImage = rgb2hsv(a);
    hsvImage(:,:,1) = rem(hsvImage(:,:,1) * 1.6, 1);
    rgbImage = hsv2rgb(hsvImage);
    [r,g,b]=haar2_wavelet(rgbImage);
    X_bar = [r,g,b];
    T2 =  ([X_bar - X_double_bar] * inv(covariance) *[X_bar - X_double_bar].' );
    test_result = [test_result,T2];
end
x=[1:1:22];
x1 = [1:1:22];
x2 = 8.276*ones([1,22]);
plot(x,test_result,x1,x2);
title("Phase II color_changed_image statistic(orange line is UCL = 8.276)")
xlabel("image number")
ylabel("T2 statistic")