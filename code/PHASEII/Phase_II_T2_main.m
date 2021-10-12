clear;
% UCL = 8.276 for m = 100,p=3,alpha = 0.05
% load cov_and_x_bar_100.mat;
load t2_150_1.mat;
imagefiles = dir('*.jpg');      
nfiles = length(imagefiles);    % Number of files found
test_result = [];
total_sample = 85;
bad_num = 40;

UCL = 8.157;

%% for bx.jpg

% calculate T statistic of each samples in Phase II
for i=1:bad_num
    
    [r,g,b]=haar2_wavelet(sprintf('b%d.jpg',i));
    X_bar = [r,g,b];
    T2 =  ([X_bar - X_double_bar] * inv(covariance) *[X_bar - X_double_bar].' );
    test_result = [test_result,T2];
end


for i=1:34

        [r,g,b]=haar2_wavelet(sprintf('g%d.png',i));
        X_bar = [r,g,b];
        T2 =  ([X_bar - X_double_bar] * inv(covariance) *[X_bar - X_double_bar].' );
        test_result = [test_result,T2];
end

for i=25:35

        [r,g,b]=haar2_wavelet(sprintf('image_part_0%d.jpg',i));
        X_bar = [r,g,b];
        T2 =  ([X_bar - X_double_bar] * inv(covariance) *[X_bar - X_double_bar].' );
        test_result = [test_result,T2];
end
x=[1:1:total_sample];
x1 = [1:1:total_sample];
x2 = UCL*ones([1,total_sample]);

% calculate the average strength length
aas = 0;
count_ = 0;
for u = 1:40
    if test_result(u) > UCL
        aas = aas + test_result(u)/UCL;
        count_ = count_ +1;
    end
end
aas = aas/count_;
% calculate the number of false alarm
false_alarm = 0;
g_index = [];
b_index = [];
for j = 1:82
    if j<=bad_num && test_result(j)<UCL
        false_alarm = false_alarm+1;
        b_index = [b_index,j];
    end
    if j>bad_num && test_result(j)>UCL
        false_alarm = false_alarm+1;
        g_index = [g_index,j-45];
    end
    
end
false_detect_rate = false_alarm/total_sample;
v_log = log2(test_result);
x2_log = log2(x2);

%  plot(x,test_result,x1,x2);
 plot(x,v_log,x1,x2_log);
 text(60,log2(UCL),'UCL')

% title("Phase II image Hotelling T2 statistic(orange line is UCL = 8.276)")
title("Phase II image Hotelling T2 statistic")
xlabel("image number")
ylabel("log2(T2 statistic)")
