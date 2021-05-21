function [r_dmax,g_dmax,b_dmax] = haar2_wavelet(image)
%HAAR2_WAVELET 此处显示有关此函数的摘要
%   r_dmax is the maximal value of diaganal detail coefficient in Red frame
%   of image
%   g_dmax is the maximal value of diaganal detail coefficient in Green frame
%   of image
%   b_dmax is the maximal value of diaganal detail coefficient in Blue frame
%   of image

i = imread(image);
% apply haart2 wavelet transform of rgb image i
[a,h,v,d] = haart2(i,5);

A1 = abs(d{5}(:,:,1));
r_dmax = max(A1,[],'all');

A2 = abs(d{5}(:,:,2));
g_dmax = max(A2,[],'all');

A3 = abs(d{5}(:,:,3));
b_dmax = max(A3,[],'all');
end