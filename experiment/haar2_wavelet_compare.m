function [h_max,hh_max,v_max,vv_max,d_max,dd_max] = haar2_wavelet_compare(image)
%HAAR2_WAVELET 此处显示有关此函数的摘要
%   r_dmax is the maximal value of diaganal detail coefficient in Red frame
%   of image
%   g_dmax is the maximal value of diaganal detail coefficient in Green frame
%   of image
%   b_dmax is the maximal value of diaganal detail coefficient in Blue frame
%   of image

i = imread(image);
% change the color of image
hsvImage = rgb2hsv(i);
hsvImage(:,:,1) = rem(hsvImage(:,:,1) * 1.6, 1);
rgbImage = hsv2rgb(hsvImage);
rgbImage = 83.2653062 * rgbImage;

% apply haart2 wavelet transform of rgb image i
[a,h,v,d] = haart2(i,5);
[aa,hh,vv,dd] = haart2(rgbImage,5);

A1 = abs(h{5});
h_max = max(A1,[],'all');

A2 = abs(v{5});
v_max = max(A2,[],'all');

A3 = abs(d{5});
d_max = max(A3,[],'all');

A11 = abs(hh{5});
hh_max = max(A11,[],'all');

A22 = abs(vv{5});
vv_max = max(A22,[],'all');

A33 = abs(dd{5});
dd_max = max(A33,[],'all');
end