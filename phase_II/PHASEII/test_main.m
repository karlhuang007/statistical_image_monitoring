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