%% this program contain samples with different color (red) than samples with original color (blue). See Section 5.2.4 in Studienarbeit
% 
m = 85;
v = [];
%% This parameter came from different color samples, uncomment it to see the the result of (red) Phase I -> (red) Phase II
%UCL = 3.7359e-04;
%% This parameter came from original samples, uncomment it to see the the result of (blue) Phase I -> (red) Phase II
UCL = 17.302;
%%
for i=1:40
    a = imread(sprintf('b%d.jpg',i));
    % transform the sample image from rgb to hsv
    hsvImage = rgb2hsv(a);
    % modify the hue value of the image
    hsvImage(:,:,1) = rem(hsvImage(:,:,1) * 1.6, 1);
    % transform hsv to rgb
    rgbImage = hsv2rgb(hsvImage);
    % extract the maximum variance
    variance_single =max_variance_of_colorpic(rgbImage);
    v = [v,variance_single];
    
end
for i=1:34
    a = imread(sprintf('g%d.png',i));
    hsvImage = rgb2hsv(a);
    hsvImage(:,:,1) = rem(hsvImage(:,:,1) * 1.6, 1);
    rgbImage = hsv2rgb(hsvImage);
    variance_single =max_variance_of_colorpic(rgbImage);
    v = [v,variance_single];
    
end
for i=25:35
    a = imread(sprintf('image_part_0%d.jpg',i));
    hsvImage = rgb2hsv(a);
    hsvImage(:,:,1) = rem(hsvImage(:,:,1) * 1.6, 1);
    rgbImage = hsv2rgb(hsvImage);
    variance_single =max_variance_of_colorpic(rgbImage);
    v = [v,variance_single];
    

end

aas = 0;
count_ = 0;
for q = 1:40
    if v(q) > UCL
        aas = aas + v(q)/UCL;
        count_ = count_ +1;
    end
end
aas = aas/count_;

false_alarm = 0;

for j = 1:m
    if j<=40 && v(j)<UCL
        false_alarm = false_alarm+1;
    else if j>40 && v(j)>UCL
         false_alarm = false_alarm+1;
    end
    end
end

x=[1:1:m];
x1 = [1:1:m];
y2 = UCL*ones([1,m]);
y3 = 49.22*ones([1,m]);

v_log = log2(v);
y2_log = log2(y2);

plot(x,v_log,x1,y2_log);
text(70,log2(UCL),'UCL')
%plot(x,v,x1,y2);
title("Phase II (use paremeters retrieved from blue image) red image maximum variance statistic")
xlabel("image number")
ylabel("log2(maximum variance statistic)")