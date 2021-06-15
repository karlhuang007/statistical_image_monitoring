
% UCL = 8.276 for m = 100,p=3,alpha = 0.05
load cov_and_x_bar_100.mat;
imagefiles = dir('*.jpg');      
nfiles = length(imagefiles);    % Number of files found
test_result = [];
for ii=1:nfiles
   currentfilename = imagefiles(ii).name;
%    currentimage = imread(currentfilename);
   [r,g,b]=haar2_wavelet(currentfilename);
   X_bar = [r,g,b];
    T2 =  ([X_bar - X_double_bar] * inv(covariance) *[X_bar - X_double_bar].' );
   test_result = [test_result,T2];
   
end

x=[1:1:121];
x1 = [1:1:121];
x2 = 8.276*ones([1,121]);

plot(x,test_result,x1,x2);
title("Phase II image statistic(orange line is UCL = 8.276)")
xlabel("image number")
ylabel("T2 statistic")