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
 y = gaussmf(x,[std(v) mean(v)]);
 % 
 y1 = 44 * y;
 
 subplot(2,2,1);
 histogram(v);
 title('original data');
 xlabel('max-variance') ;
ylabel('nums of image') ;

 
 subplot(2,2,2);
 plot(x,y1);
 title('transformed data');
 xlabel('max-variance') ;
ylabel('nums of image') ;
 
 subplot(2,2,3);
 autocorr(v);
 title('autocorrelation plot of data');
 figure

%calculate the mean
mean_variance_of_good_slide  = mean(v);
variance_of_good_slide = var(v);
