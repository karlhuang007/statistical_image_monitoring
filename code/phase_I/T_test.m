function [i23_T_sqaur] = T_test(image,X_bar_final,cov_final)

g2 = imread(image);
[m,n,c] = size(g2);

% process the size of image
if mod(m,4)~=0
    m = m -mod(m,4);
end

if mod(n,4)~=0
    n = n -mod(n,4);
end

T_sqaur = [];
for i = 1 : (m/4)
    for j = 1: (n/4)
        % multivariate processing unit has 4*4 pixel
        multivariate_processing_unit = g2(4*(i-1)+1 :4*i, 4*(j-1)+1 :4*j,:);
        X_BAR_RGB = wavelet_rgb(multivariate_processing_unit);
        % formula 26
        T2 = 4 * ([X_BAR_RGB - X_bar_final] * inv(cov_final) *[X_BAR_RGB - X_bar_final].' );
        T_sqaur = [T_sqaur,T2];
    end
end
% result of image_part_023.png
i23_T_sqaur = reshape(T_sqaur,[m/4,n/4]);

end


function [A,D,A_SM_squar,D_SM_squar,COV_AD] = wavelet_transform(multivariate_processing_unit )
%WAVELET_TRANSFORM this function perform four wavelet transforms in input
%multivariate processing unit and return the A and D value of X_M_bar
%  PARA multivariate_processing_unit is 4*4 pixel in of R/G/B frame of
%  image

[m,n] = size(multivariate_processing_unit);
% m and n must be even protect here
if mod(m,2)~=0
    m = m -1;
end

if mod(n,2)~=0
    n = n -1;
end

A_vector = [];
D_vector = [];
    
for i = 1 : (m/2)
    for j = 1: (n/2)
        % wavelet processing unit has 4*4 pixel
        wavelet_processing_unit = multivariate_processing_unit(2*i-1 :2*i, 2*j-1:2*j);
        [a,h,v,d] = haart2(wavelet_processing_unit,'integer');
        A_vector = [A_vector,a];
        % fomula 16
        d_value = 1/3 * h + 1/3 * v + 1/3 * d;
        D_vector = [D_vector,d_value];
    end
end
% Formula 17
A = mean(A_vector);
D = mean(D_vector);
% formula 19
A_SM_squar = var(A_vector);
D_SM_squar = var(D_vector);
s = size(A_vector);
sum = 0;
for k = 1:s
    sum = sum + (A_vector(k)-A)*(D_vector - D);
end
COV_AD = sum/(m*n-1);
end

function [X_BAR_RGB] = wavelet_rgb(image_unit)
%WAVELET_RGB recieve an multivariate processing unit of rgb frame and return X_BAR_RGB 
%   para image_unit's size(4,4,3);
[m,n,c] = size(image_unit);
X = [];
for k = 1:3
    wavelet_processing_unit = image_unit(:,:,k);
    [A,D,A_SM_squar,D_SM_squar] = wavelet_transform(wavelet_processing_unit );
    X = [X,A,D];
end
X_BAR_RGB = X;

end

