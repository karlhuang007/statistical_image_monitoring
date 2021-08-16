

v= [];

for i=1:15
    a = imread(sprintf('g%d.png',i));
    hsvImage = rgb2hsv(a);
    hsvImage(:,:,1) = rem(hsvImage(:,:,1) * 1.6, 1);
    rgbImage = hsv2rgb(hsvImage);
    variance_single =max_variance_of_pic(rgbImage);
    v = [v,variance_single];
    
end

for i=1:85
    if i<10
        a = imread(sprintf('image_part_00%d.jpg',i));
        hsvImage = rgb2hsv(a);
        hsvImage(:,:,1) = rem(hsvImage(:,:,1) * 1.6, 1);
        rgbImage = hsv2rgb(hsvImage);
        variance_single =max_variance_of_pic(rgbImage);
        v = [v,variance_single];
    else
        a = imread(sprintf('image_part_0%d.jpg',i));
        hsvImage = rgb2hsv(a);
        hsvImage(:,:,1) = rem(hsvImage(:,:,1) * 1.6, 1);
        rgbImage = hsv2rgb(hsvImage);
        variance_single =max_variance_of_pic(rgbImage);
        v = [v,variance_single];
    end

end
% for i=1:13
% 	variance =max_variance_of_pic(sprintf('g%d.png',i));
%     v = [v,variance];
% end
% 
% for i=1:24
%     if i<10
%         v1=max_variance_of_pic(sprintf('image_part_00%d.jpg',i));
%     else
%         v1=max_variance_of_pic(sprintf('image_part_0%d.jpg',i));
%     end
%     v = [v,v1];
% 
% end



 h1 = histogram(v);
 % 55 images
 x=[1:1:100];
 % transform the images' variance vector into normal distribution 
%  y = gaussmf(x,[std(v) mean(v)]);
 % 
%  y1 = 44 * y;
 
 subplot(2,2,1);
 histogram(v);
 title('original data');
 xlabel('max-variance') ;
ylabel('nums of image') ;

 
 subplot(2,2,2);
 plot(x,v);
 title('maximum variance of phase I data');
 xlabel('max-variance') ;
ylabel('nums of image') ;
%  
%  subplot(2,2,3);
%  autocorr(v);
%  title('autocorrelation plot of data');
 

%calculate the mean
mean_variance_of_good_slide  = mean(v);

v_sum = 0;
for k = 1:100
    v_sum = v_sum + (v(k) - mean_variance_of_good_slide)^2;
end
s = sqrt(v_sum/99);
nn = 99/2 -1;
fac_48 = 1;
for q = 0:48
    fac_48 = fac_48 * (48.5 -q);
end
fac_48 = fac_48 * sqrt(pi);
fac_49 = factorial(49);
c_4 = sqrt(2/99) * (fac_49/fac_48);

sigma_s = s/c_4 * sqrt(1-c_4^2);
UCL = mean_variance_of_good_slide + 3* sigma_s;
LCL = mean_variance_of_good_slide - 3* sigma_s;


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