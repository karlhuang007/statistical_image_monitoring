%% for bx.jpg
m = 85;
v = [];
UCL = 3.7359e-04;

for i=1:40
    a = imread(sprintf('b%d.jpg',i));
    hsvImage = rgb2hsv(a);
    hsvImage(:,:,1) = rem(hsvImage(:,:,1) * 1.6, 1);
    rgbImage = hsv2rgb(hsvImage);
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
title("Phase II color changed image maximum variance statistic")
xlabel("image number")
ylabel("log2(maximum variance statistic)")