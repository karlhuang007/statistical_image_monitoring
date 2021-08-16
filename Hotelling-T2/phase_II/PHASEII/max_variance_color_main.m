%% for bx.jpg

v = [];
for i=1:23
    a = imread(sprintf('b%d.jpg',i));
    hsvImage = rgb2hsv(a);
    hsvImage(:,:,1) = rem(hsvImage(:,:,1) * 1.6, 1);
    rgbImage = hsv2rgb(hsvImage);
    variance_single =max_variance_of_pic(rgbImage);
    v = [v,variance_single];
    
end



for i=1:97
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
% haar2_wavelet using 3d has 22 false alarm
% haar2_wavelet using hdv has 13 false alarm
false_alarm = 0;
for j = 1:120
    if j<=47 && v(j)<0.0016
        false_alarm = false_alarm+1;
    if j>47 && v(j)>0.0016
         false_alarm = false_alarm+1;
    end
    end
end
x=[1:1:120];
x1 = [1:1:120];
y2 = 0.0016*ones([1,120]);
y3 = 49.22*ones([1,120]);

v_log = log2(v);
y2_log = log2(y2);

plot(x,v_log,x1,y2_log);

%plot(x,v,x1,y2);
title("Phase II color changed image maximum variance statistic(orange line is UCL)")
xlabel("image number")
ylabel("log2(maximum variance statistic)")