function [outputArg1] = image_process_function(image)
%IMAGE_PROCESS_FUNCTION 此处显示有关此函数的摘要
%   此处显示详细说明
b1 = imread(image);
r = b1(:,:,1);
g = b1(:,:,2);
b = b1(:,:,3);


% first step calculate X_doublebar and covariance function of a normal image
[AR_bar,DR_bar,S_AR_square,S_DR_square,COV_AD_R] = RGB_Xbar_and_variance(r);
[AG_bar,DG_bar,S_AG_square,S_DG_square,COV_AD_G] = RGB_Xbar_and_variance(g);
[AB_bar,DB_bar,S_AB_square,S_DB_square,COV_AD_B] = RGB_Xbar_and_variance(b);
%formula 24
X_doublebar = [AR_bar,DR_bar,AG_bar,DG_bar,AB_bar,DB_bar];
S_square = [S_AR_square,S_DR_square,S_AG_square,S_DG_square,S_AB_square,S_DB_square];
COV_AD = [COV_AD_R,COV_AD_G,COV_AD_B];
% calculate covariance function
n=6; % number of observation
%formula 25
% for i = 1:n
%     for j = 1:n
%         % use ceil(i/25),ceil(j/25) to retrieve the row number of i,j in the checkerboard,
%         % use mod(i,25),mod(j,25) to retrieve the column number of i,j in
%         % the checkerboard. when mod(i,25) = 0, it mean the column is 25.
%         % so the following situations should be considered.
%         % Y = ceil( X ) rounds each element of X to the nearest integer greater than or equal to that element
%         % b = mod( a , m ) returns the remainder after division of a by m
%         
%         % same image
%         if abs(i-j)<2
%             if i == j
%                 cov(i,j) = S_square(i);
%             else
%                 % calculate the covariance of the A and D in same image
% %                 if i/2 <=1
% %                     cov(i,j) = covariance_in_same(r);
% %                 elseif i/2 >1 && i/2 <=2 
% %                     cov(i,j) = covariance_in_same(g);
% %                 else
% %                     cov(i,j) = covariance_in_same(b);
% %                 end
%                 % formula 21
%                 cov(i,j) = COV_AD(ceil(i/2));
%             end
%         else
%             % different image % formula 22
%             cov(i,j) =  covariance_in_diff(b1(:,:,ceil(i/2)),b1(:,:,ceil(i/2)),i,j);
%         end     
%     end
% end
outputArg1 = X_doublebar;
% outputArg2 = cov;
end

function [A_bar,D_bar,S_AP_square,S_DP_square,COV_AD] = RGB_Xbar_and_variance(mono_pic)
%UNTITLED this function calculate the A_doublebar and D_doublebar of
%mono_pic
% para mono_pic is the R/G/B value of a color picture
%   此处显示详细说明

[m,n] = size(mono_pic);
% m and n must be even protect here
if mod(m,4)~=0
    m = m -mod(m,4);
end

if mod(n,4)~=0
    n = n -mod(n,4);
end
A_vector = [];
D_vector = [];
S_A_vector = [];
S_D_vector = [];
S_AD_vector = [];
    
for i = 1 : (m/4)
    for j = 1: (n/4)
        % multivariate processing unit has 4*4 pixel
        multivariate_processing_unit = mono_pic(4*(i-1)+1 :4*i, 4*(j-1)+1 :4*j);
        [A,D,S_A,S_D,COV_AD] = wavelet_transform(multivariate_processing_unit);
        A_vector = [A_vector,A];
        D_vector = [D_vector,D];
        S_A_vector = [S_A_vector,S_A];
        S_D_vector = [S_D_vector,S_D];
        S_AD_vector = [S_AD_vector,COV_AD];
    end
end
%fomular 18
A_bar = mean(A_vector);
D_bar = mean(D_vector);
S_AP_square = mean(S_A_vector);
S_DP_square = mean(S_D_vector);
COV_AD = mean(S_AD_vector);
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

function [cov] = bi_wavelet_transform(unit1,unit2,num1,num2)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
[m,n] = size(unit1);
% m and n must be even protect here
if mod(m,2)~=0
    m = m -1;
end

if mod(n,2)~=0
    n = n -1;
end

vector1 = [];
vector2 = [];
if mod(num1,2)~=0 && mod(num2,2)~=0
        % covariance of image1's A and image2's A
        for i = 1 : (m/2)
            for j = 1: (n/2)
                % wavelet processing unit has 4*4 pixel
                wavelet_processing_unit1 = unit1(2*i-1 :2*i, 2*j-1:2*j);
                [a1,h1,v1,d1] = haart2(wavelet_processing_unit1,'integer');
                vector1 = [vector1,a1];
                % fomula 16
                wavelet_processing_unit2 = unit2(2*i-1 :2*i, 2*j-1:2*j);
                [a2,h2,v2,d2] = haart2(wavelet_processing_unit2,'integer');
                vector2 = [vector2,a2];
            end
        end
        A1_mean = mean(vector1);
        A2_mean = mean(vector2);
        s = size(unit1);
        sum = 0;
        for k = 1:s
            sum = sum+(vector1(k)-A1_mean)*(vector2(k)-A2_mean);
        end
        cov = sum/(m*n-1);
elseif mod(num1,2)==0 && mod(num2,2)==0
        % covariance of image1's D and image2's D
        for i = 1 : (m/2)
            for j = 1: (n/2)
                % wavelet processing unit has 4*4 pixel
                wavelet_processing_unit1 = unit1(2*i-1 :2*i, 2*j-1:2*j);
                [a1,h1,v1,d1] = haart2(wavelet_processing_unit1,'integer');

                d_value1 = 1/3 * h1 + 1/3 * v1 + 1/3 * d1;

                vector1 = [vector1,d_value1];
                % fomula 16
                wavelet_processing_unit2 = unit2(2*i-1 :2*i, 2*j-1:2*j);
                [a2,h2,v2,d2] = haart2(wavelet_processing_unit2,'integer');
                d_value2 = 1/3 * h2 + 1/3 * v2 + 1/3 * d2;
                vector2 = [vector2,d_value2];
            end
        end
        A1_mean = mean(vector1);
        A2_mean = mean(vector2);
        s = size(unit1);
        sum = 0;
        for k = 1:s
            sum = sum+(vector1(k)-A1_mean)*(vector2(k)-A2_mean);
        end
        cov = sum/(m*n-1);
else
    if mod(num1,2)~=0 && mod(num2,2)==0
        % iamge1'A and image2' D
        for i = 1 : (m/2)
            for j = 1: (n/2)
                % wavelet processing unit has 4*4 pixel
                wavelet_processing_unit1 = unit1(2*i-1 :2*i, 2*j-1:2*j);
                [a1,h1,v1,d1] = haart2(wavelet_processing_unit1,'integer');
                vector1 = [vector1,a1];
                % fomula 16
                wavelet_processing_unit2 = unit2(2*i-1 :2*i, 2*j-1:2*j);
                [a2,h2,v2,d2] = haart2(wavelet_processing_unit2,'integer');
                d_value2 = 1/3 * h2 + 1/3 * v2 + 1/3 * d2;
                vector2 = [vector2,d_value2];
            end
        end
        A1_mean = mean(vector1);
        A2_mean = mean(vector2);
        s = size(unit1);
        sum = 0;
        for k = 1:s
            sum = sum+(vector1(k)-A1_mean)*(vector2(k)-A2_mean);
        end
        cov = sum/(m*n-1);
    else
        % % iamge1'D and image2' A
        for i = 1 : (m/2)
            for j = 1: (n/2)
                % wavelet processing unit has 4*4 pixel
                wavelet_processing_unit1 = unit1(2*i-1 :2*i, 2*j-1:2*j);
                [a1,h1,v1,d1] = haart2(wavelet_processing_unit1,'integer');
                d_value1 = 1/3 * h1 + 1/3 * v1 + 1/3 * d1;
                vector1 = [vector1,d_value1];
                % fomula 16
                 wavelet_processing_unit2 = unit2(2*i-1 :2*i, 2*j-1:2*j);
                [a2,h2,v2,d2] = haart2(wavelet_processing_unit2,'integer');
                vector2 = [vector2,a2];
            end
        end
        A1_mean = mean(vector1);
        A2_mean = mean(vector2);
        s = size(unit1);
        sum = 0;
        for k = 1:s
            sum = sum+(vector1(k)-A1_mean)*(vector2(k)-A2_mean);
        end
        cov = sum/(m*n-1);
    end
end

end



function [covariance] = covariance_in_diff(image1,image2,num1,num2)
%COVARIANCE_IN_DIFF 此处显示有关此函数的摘要
%   此处显示详细说明
% image1 and image2 have same size
[m,n] = size(image1);
% m and n must be even protect here
if mod(m,4)~=0
    m = m -mod(m,4);
end

if mod(n,4)~=0
    n = n -mod(n,4);
end
cov_vector= [];
%

    for i = 1 : (m/4)
        for j = 1: (n/4)
        % multivariate processing unit has 4*4 pixel
        multivariate_processing_unit1 = image1(4*(i-1)+1 :4*i, 4*(j-1)+1 :4*j);
        multivariate_processing_unit2 = image2(4*(i-1)+1 :4*i, 4*(j-1)+1 :4*j);
        cov = bi_wavelet_transform(multivariate_processing_unit1,multivariate_processing_unit2,num1,num2);
        cov_vector = [cov_vector,cov];
        end
    end

covariance = mean(cov_vector);
end




