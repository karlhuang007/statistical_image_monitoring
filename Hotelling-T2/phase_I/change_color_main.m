 X_bar_set = [];
cov_set = [];

% calculate every normal image's covariance matrix and mean vector    
for i=1:15
    a = imread(sprintf('g%d.png',i));
    hsvImage = rgb2hsv(a);
    hsvImage(:,:,1) = rem(hsvImage(:,:,1) * 1.6, 1);
    rgbImage = hsv2rgb(hsvImage);
    [r,g,b]=haar2_wavelet(rgbImage);
    X_bar_set = [X_bar_set;r,g,b];
    
end

for i=1:85
    if i<10
        %[r,g,b]=haar2_wavelet(sprintf('image_part_00%d.jpg',i));
        a = imread(sprintf('image_part_00%d.jpg',i));
        hsvImage = rgb2hsv(a);
        hsvImage(:,:,1) = rem(hsvImage(:,:,1) * 1.6, 1);
        rgbImage = hsv2rgb(hsvImage);
        [r,g,b]=haar2_wavelet(rgbImage);
    else
        %[r,g,b]=haar2_wavelet(sprintf('image_part_0%d.jpg',i));
        a = imread(sprintf('image_part_0%d.jpg',i));
        hsvImage = rgb2hsv(a);
        hsvImage(:,:,1) = rem(hsvImage(:,:,1) * 1.6, 1);
        rgbImage = hsv2rgb(hsvImage);
        [r,g,b]=haar2_wavelet(rgbImage);
    end
    X_bar_set = [X_bar_set;r,g,b];

end

% for i=37:40
%     
%     [X_bar]=haar2_wavelet(sprintf('image_part_0%d.jpg',i));
%     
%     X_bar_set = [X_bar_set;r,g,b];
% 
% end
X_double_bar = mean(X_bar_set);
[m,n] = size(X_bar_set);

for i = 1:3
    for j = 1:3
        num = 0.0;
        if i==j
            covariance1(i,j) = var(X_bar_set(:,i));
        else
            
            for k = 1: m
                a = X_bar_set(k,i) - X_double_bar(i);
                b = X_bar_set(k,j) - X_double_bar(j);
%                 num = num + ((X_bar_set(m,i) - X_double_bar(i)) * (X_bar_set(m,j) - X_double_bar(j)));
                num = num + a*b;
            end
            covariance1(i,j) =  num/(m-1);
        end
    end
end
covariance = cov(X_bar_set);
% for i = 1:3
%     for j = 1:3
%         if i==j
%             cov(i,j) = var(X_bar_set(:,i));
%         else
% %             num = 0.0;
% %             for k = 1: m
% %                 num = num + ((X_bar_set(m,i) - X_double_bar(i)) * (X_bar_set(m,j) - X_double_bar(j)));
% %             end
%             cov(i,j) = cov(X_bar_set(:,i).',X_bar_set(:,j).');
%         end
%     end
% end
% cov_ = cov()
% autocorelate plot of six parameter
% subplot(3,1,1);
% autocorr(X_bar_set(:,1));
% title('autocorr plot of the maximal value of diaganal detail coefficient in Red frame of phase I images');
% subplot(3,1,2);
% autocorr(X_bar_set(:,2));
% title('autocorr plot of the maximal value of diaganal detail coefficient in Green frame of phase I images');
% 
% subplot(3,1,3);
% autocorr(X_bar_set(:,3));
% title('autocorr plot of the maximal value of diaganal detail coefficient in Blue frame of phase I images');
% 

% comparative test(normal image) 
% test_result = [];
% for i=41:54
%     [r,g,b]=haar2_wavelet(sprintf('image_part_0%d.jpg',i));
%     X_bar = [r,g,b];
%     T2 =  ([X_bar - X_double_bar] * inv(covariance) *[X_bar - X_double_bar].' );
%    test_result = [test_result,T2];
% end
% % comparative test(defect image) 
% defect_result = [];
% for i=1:5
%     [r,g,b]=haar2_wavelet(sprintf('b%d.png',i));
%     X_bar = [r,g,b];
%     T2 =  ([X_bar - X_double_bar] * inv(covariance) *[X_bar - X_double_bar].' );
%    defect_result = [defect_result,T2];
% end






