% this file calculate the phase I data of covariance matrix and mean vector
% of a normal rgb image
    
X_bar_set = [];
cov_set = [];

% calculate every normal image's covariance matrix and mean vector    
for i=1:13
    [X_bar]=image_process_function(sprintf('g%d.png',i));
    X_bar_set = [X_bar_set;X_bar];
    
end

for i=1:24
    if i<10
        [X_bar]=image_process_function(sprintf('image_part_00%d.jpg',i));
    else
        [X_bar]=image_process_function(sprintf('image_part_0%d.jpg',i));
    end
    X_bar_set = [X_bar_set;X_bar];

end

for i=37:40
    
    [X_bar]=image_process_function(sprintf('image_part_0%d.jpg',i));
    
    X_bar_set = [X_bar_set;X_bar];

end
X_double_bar = mean(X_bar_set);
[m,n] = size(X_bar_set);
% calculate covariance matrix of m pic
for i = 1:6
    for j = 1:6
        if i==j
            cov(i,j) = var(X_bar_set(:,i));
        else
            num = 0;
            for k = 1: m
                num = num + ((X_bar_set(m,i) - X_double_bar(i)) * (X_bar_set(m,j) - X_double_bar(j)));
            end
            cov(i,j) = num / (m-1);
        end
    end
end

% autocorelate plot of six parameter
subplot(3,2,1);
autocorr(X_bar_set(:,1));
title('autocorr plot of AR');
subplot(3,2,2);
autocorr(X_bar_set(:,2));
title('autocorr plot of DR');

subplot(3,2,3);
autocorr(X_bar_set(:,3));
title('autocorr plot of AG');

subplot(3,2,4);
autocorr(X_bar_set(:,4));
title('autocorr plot of DG');

subplot(3,2,5);
autocorr(X_bar_set(:,5));
title('autocorr plot of AB');

subplot(3,2,6);
autocorr(X_bar_set(:,6));
title('autocorr plot of DB');

% tttest of 6 parameters
h1 = ttest(X_bar_set(:,1));
h2 = ttest(X_bar_set(:,2));
h3 = ttest(X_bar_set(:,3));
h4 = ttest(X_bar_set(:,4));
h5 = ttest(X_bar_set(:,5));
h6 = ttest(X_bar_set(:,6));


% comparative test(normal image) 
test_result = [];
for i=41:54
    [X_bar]=image_process_function(sprintf('image_part_0%d.jpg',i));
    T2 = m * ([X_bar - X_double_bar] * inv(cov) *[X_bar - X_double_bar].' );
   test_result = [test_result,T2];
end
% comparative test(defect image) 
[b1_X_bar] = image_process_function("b1.png");
b1_result = m * ([b1_X_bar - X_double_bar] * inv(cov) *[b1_X_bar - X_double_bar].' );

[s1_X_bar] = image_process_function("scratch1.png");
s1_result = m * ([s1_X_bar - X_double_bar] * inv(cov) *[s1_X_bar - X_double_bar].' );
% average the covariance matrix and mean vector of 40 normal images