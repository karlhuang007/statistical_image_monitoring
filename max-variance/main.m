% bad slide
max_b1 = max_variance_of_pic('b1.png');
max_b2 = max_variance_of_pic('scratch1.png');

v= [];
for i=1:13
	variance =max_variance_of_pic(sprintf('g%d.png',i));
    v = [v,variance];
end

for i=1:24
    if i<10
        v1=max_variance_of_pic(sprintf('image_part_00%d.jpg',i));
    else
        v1=max_variance_of_pic(sprintf('image_part_0%d.jpg',i));
    end
    v = [v,v1];

end

for i=37:54
    
        v2=max_variance_of_pic(sprintf('image_part_0%d.jpg',i));
    
    v = [v,v2];

end



 h1 = histogram(v);
 % 55 images
 x=[1:1:55];
 % transform the images' variance vector into normal distribution 
%  y = gaussmf(x,[std(v) mean(v)]);
 % 
%  y1 = 44 * y;
 
 subplot(2,2,1);
 histogram(v);
 title('original data');
 xlabel('max-variance') ;
ylabel('nums of image') ;

 
%  subplot(2,2,2);
%  plot(x,y1);
%  title('transformed data');
%  xlabel('max-variance') ;
% ylabel('nums of image') ;
 
 subplot(2,2,3);
 autocorr(v);
 title('autocorrelation plot of data');
 

%calculate the mean
mean_variance_of_good_slide  = mean(v);
variance_of_good_slide = var(v);
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