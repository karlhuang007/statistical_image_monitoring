a = imread('e4.png');
hsvImage = rgb2hsv(a);
hsvImage(:,:,1) = rem(hsvImage(:,:,1) * 1.6, 1);
rgbImage = hsv2rgb(hsvImage);
subplot(1,2,1);
imshow(a);
subplot(1,2,2);
imshow(rgbImage);