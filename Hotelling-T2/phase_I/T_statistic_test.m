% load the the mean matrix and the covariance matrix of image characteristics of 40 normal
% images(image_part_01 - image_part_40) calculated by rgb_maim.m;
load('cov_40.mat');
load('x_bar_40.mat');

% use covariance matrix and X_bar vector calculated by rgb_main(used 40
% good images) to test the T^2 statistic of 14 good images
C_good = cell([2,7]);
T_i=T_test('image_part_042.jpg',X_bar_final,cov_final);
j = 1;
for i=41:54
    
   C_good{j}=T_test(sprintf('image_part_0%d.jpg',i),X_bar_final,cov_final);
    j =j+  1;
end
% use covariance matrix and X_bar vector calculated by rgb_main(used 40
% good images) to test the T^2 statistic of 2 scratch images

C_bad = cell([2,1]);
C_bad{1} = T_test('b1.png',X_bar_final,cov_final);
C_bad{2} = T_test('scratch1.png',X_bar_final,cov_final);