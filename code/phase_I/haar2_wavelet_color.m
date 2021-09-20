function [h_max,v_max,d_max] = haar2_wavelet_color(image)
%HAAR2_WAVELET 此处显示有关此函数的摘要
%   r_dmax is the maximal value of diaganal detail coefficient in Red frame
%   of image
%   g_dmax is the maximal value of diaganal detail coefficient in Green frame
%   of image
%   b_dmax is the maximal value of diaganal detail coefficient in Blue frame
%   of image

% for rgb_main
% i = imread(image);
% % apply haart2 wavelet transform of rgb image i
% [a,h,v,d] = haart2(i,5);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% for change_color_main 
 [a,h,v,d] = haart2(image,5);
%%%%%%%%%
A1 = abs(h{5});
h_max = max(A1,[],'all');

A2 = abs(v{5});
v_max = max(A2,[],'all');

A3 = abs(d{5});
d_max = max(A3,[],'all');
end


