% imagefiles = dir('*.jpg');      
% nfiles = length(imagefiles);    % Number of files found
% test_result = [];
clear;
v = [];
m = 85;
UCL = 17.302;
%% for image_part_00x
% for ii=1:nfiles
%    currentfilename = imagefiles(ii).name;
% %    currentimage = imread(currentfilename);
%     variance_single =max_variance_of_pic(currentfilename);
%     v = [v,variance_single];
%   
%    
% end

for i=1:40
    variance_single =max_variance_of_pic(sprintf('b%d.jpg',i));
    v = [v,variance_single];

end
for i=1:34

        variance_single =max_variance_of_pic(sprintf('g%d.png',i));
        v = [v,variance_single];
end

for i=25:35
    
        variance_single =max_variance_of_pic(sprintf('image_part_0%d.jpg',i));
        v = [v,variance_single];
    

end
x=[1:1:m];

y2 = UCL*ones([1,m]);
y3 = 49.22*ones([1,m]);

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
false_detect_rate = false_alarm/m;
v_log = log2(v);
y2_log = log2(y2);

 plot(x,v_log,x,y2_log);
 text(70,log2(UCL),'UCL')
% plot(x,v,x,y2);
title("Phase II image maximum variance statistic")
xlabel("image number")
ylabel("log2(maximum variance statistic)")