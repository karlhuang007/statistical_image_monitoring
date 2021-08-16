% A = imread('e1.png');
% B = imread('e2.png');
% C = imread('e3.png');
% [a1,h1,v1,d1] = haart2(A,5);
% [a2,h2,v2,d2] = haart2(B,5);
% [a3,h3,v3,d3] = haart2(C,5);
%%
% [h1,v1,d1] = haar2_wavelet('e1.png');
% [h2,v2,d2] = haar2_wavelet('e2.png');
% [h3,v3,d3] = haar2_wavelet('e3.png');
% 
% 
% [h4,v4,d4] = haar2_wavelet('e4.png');
% 
% [h5,v5,d5] = haar2_wavelet('e5.png');
% [h6,v6,d6] = haar2_wavelet('e6.png');
%%
[h4,hh4,v4,vv4,d4,dd4] = haar2_wavelet_compare('b1.jpg');

[h5,hh5,v5,vv5,d5,dd5] = haar2_wavelet_compare('b3.jpg');
[h6,hh6,v6,vv6,d6,dd6] = haar2_wavelet_compare('e4.png');



