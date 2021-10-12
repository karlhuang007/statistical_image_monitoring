clear;

v= [];
m = 150;

% calculate the variance of samples
for i=1:35
    variance =max_variance_of_pic(sprintf('g%d.png',i));
    v = [v,variance];
    
end

for i=1:115
    if i<10
        v1=max_variance_of_pic(sprintf('image_part_00%d.jpg',i));
    elseif i>=10 && i <100 
        v1=max_variance_of_pic(sprintf('image_part_0%d.jpg',i));
    else
        v1=max_variance_of_pic(sprintf('image_part_%d.jpg',i));
    end

    
    v = [v,v1];

end

%calculate the mean
mean_variance_of_good_slide  = mean(v);

% calculate the sigma_s of sample to finally determine the UCL
% see Equation (4.1) - (4.4) in Studienarbeit
v_sum = 0;
for k = 1:m
    v_sum = v_sum + (v(k) - mean_variance_of_good_slide)^2;
end
s = sqrt(v_sum/m);
nn = m/2 -1;
fac_48 = 1;
for q = 0:nn-1
    fac_48 = fac_48 * (nn-0.5 -q);
end
fac_48 = fac_48 * sqrt(pi);
fac_49 = factorial(m/2-1);
c_4 = sqrt(2/(m-1)) * fac_49/fac_48;

sigma_s = s/c_4 * sqrt(1-c_4^2);
UCL = mean_variance_of_good_slide + 3* sigma_s;
LCL = mean_variance_of_good_slide - 3* sigma_s;

%  h1 = histogram(v);
% plot control chart result
x=[1:1:m];
y = UCL*ones([1,m]);

v_log = log2(v);
x2_log = log2(y);

%   plot(x,test_result,x1,x2);
  
  plot(x,v_log,x,x2_log);
%  subplot(2,2,2);
%  plot(x,v,x,y);
   text(136,log2(UCL),'UCL')
 title('maximum variance of phase I data');
 xlabel('nums of image') ;
ylabel('max-variance');
  
%  subplot(2,2,3);
%  autocorr(v);


% calculate the false alarm rate
bad_sample_index = [];
false_alarm = 0;
for j = 1:m
    if(v(j)>UCL)
        false_alarm = false_alarm+1;
        if j<=35
            bad_sample_index = [bad_sample_index,j];
        else
            bad_sample_index = [bad_sample_index,j-35];
        end
    end
end
% p denoting the probability of an observation plotting outside the control limits.
    p = false_alarm/m;
    average_run_length = 1/p;




%% EXPERIMENT MAX SIZE OF SLIDING WINDOW
% v5_1 = max_size('b1.jpg',5);
% v5_2 = max_size('b3.jpg',5);
% v5_3 = max_size('b16.jpg',5);
% 
% v10_1 = max_size('b1.jpg',10);
% v10_2 = max_size('b3.jpg',10);
% v10_3 = max_size('b16.jpg',10);
% 
% v20_1 = max_size('b1.jpg',20);
% v20_2 = max_size('b3.jpg',20);
% v20_3 = max_size('b16.jpg',20);


% \toprule
% window size & image (a) & image (b) & image (c)
% \midrule
% $5*5$ & 1 & 2 & 3 \\   
% $10*10$ & 1 & 2 & 3 \\   
% $20*20$ & 1 & 2 & 3 \\ 