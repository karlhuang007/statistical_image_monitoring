
% UCL = 8.276 for m = 100,p=3,alpha = 0.05
%load cov_and_x_bar_100.mat;
load cov_x_hvd.mat;
imagefiles = dir('*.jpg');      
nfiles = length(imagefiles);    % Number of files found
test_result = [];
%% for image_part_00x
% for ii=1:nfiles
%    currentfilename = imagefiles(ii).name;
% %    currentimage = imread(currentfilename);
%    [r,g,b]=haar2_wavelet(currentfilename);
%    X_bar = [r,g,b];
%     T2 =  ([X_bar - X_double_bar] * inv(covariance) *[X_bar - X_double_bar].' );
%    test_result = [test_result,T2];
%    
% end
% x=[1:1:120];
% x1 = [1:1:120];
% x2 = 8.276*ones([1,120]);
% 
% plot(x,test_result,x1,x2);
% title("Phase II image statistic(orange line is UCL = 8.276)")
% xlabel("image number")
% ylabel("T2 statistic")
%% for bx.jpg
for i=1:22
    
    [r,g,b]=haar2_wavelet(sprintf('b%d.jpg',i));
    X_bar = [r,g,b];
    T2 =  ([X_bar - X_double_bar] * inv(covariance) *[X_bar - X_double_bar].' );
    test_result = [test_result,T2];
end


for i=1:98
    if i<10
        [r,g,b]=haar2_wavelet(sprintf('image_part_00%d.jpg',i));
        
        X_bar = [r,g,b];
        T2 =  ([X_bar - X_double_bar] * inv(covariance) *[X_bar - X_double_bar].' );
        test_result = [test_result,T2];
    else
        [r,g,b]=haar2_wavelet(sprintf('image_part_0%d.jpg',i));
        
        X_bar = [r,g,b];
        T2 =  ([X_bar - X_double_bar] * inv(covariance) *[X_bar - X_double_bar].' );
        test_result = [test_result,T2];
    end

end
x=[1:1:120];
x1 = [1:1:120];
x2 = 8.276*ones([1,120]);

plot(x,test_result,x1,x2);
title("Phase II image statistic(orange line is UCL = 8.276)")
xlabel("image number")
ylabel("T2 statistic")
