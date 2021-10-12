function [h_max,v_max,d_max] = haar2_wavelet(image)
%HAAR2_WAVELET this function correspond to The process describe at Figure 4.2 

% image is the sample with original color 

%   h_max is the maximal value of Horizontal detail coefficient in Red frame
%   of image
%   v_max is the maximal value of Verticle detail coefficient in Green frame
%   of image
%   d_max is the maximal value of Diaganal detail coefficient in Blue frame
%   of image
% 
% for rgb_main
i = imread(image);
% apply haart2 wavelet transform of rgb image i
[a,h,v,d] = haart2(i,5);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% for change_color_main 
%  [a,h,v,d] = haart2(image,5);

A1 = abs(h{5});
h_max = max(A1,[],'all');

A2 = abs(v{5});
v_max = max(A2,[],'all');

A3 = abs(d{5});
d_max = max(A3,[],'all');
end
