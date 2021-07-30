% A = imread('e1.png');
% B = imread('e2.png');
% C = imread('e3.png');
% [a1,h1,v1,d1] = haart2(A,5);
% [a2,h2,v2,d2] = haart2(B,5);
% [a3,h3,v3,d3] = haart2(C,5);
%%
[h1,v1,d1] = haar2_wavelet('e1.png');
[h2,v2,d2] = haar2_wavelet('e2.png');
[h3,v3,d3] = haar2_wavelet('e3.png');


[h4,v4,d4] = haar2_wavelet('b1.png');

[h5,v5,d5] = haar2_wavelet('b2.png');

