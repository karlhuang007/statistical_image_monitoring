% imagefiles = dir('*.jpg');      
% nfiles = length(imagefiles);    % Number of files found
% test_result = [];
v = [];
%% for image_part_00x
% for ii=1:nfiles
%    currentfilename = imagefiles(ii).name;
% %    currentimage = imread(currentfilename);
%     variance_single =max_variance_of_pic(currentfilename);
%     v = [v,variance_single];
%   
%    
% end

for i=1:23
    variance_single =max_variance_of_pic(sprintf('b%d.jpg',i));
    v = [v,variance_single];

end


for i=1:97
    if i<10
        variance_single =max_variance_of_pic(sprintf('image_part_00%d.jpg',i));
        v = [v,variance_single];
    else
        variance_single =max_variance_of_pic(sprintf('image_part_0%d.jpg',i));
        v = [v,variance_single];
    end

end
x=[1:1:120];
x1 = [1:1:120];
y2 = 82.3*ones([1,120]);
y3 = 49.22*ones([1,120]);

aas = 0;
count_ = 0;
for q = 1:47
    if v(q) > 82.3
        aas = aas + v(q)/82.3;
        count_ = count_ +1;
    end
end
aas = aas/count_;

false_alarm = 0;
for j = 1:120
    if j<=47 && v(j)<82.3
        false_alarm = false_alarm+1;
    if j>47 && v(j)>82.3
         false_alarm = false_alarm+1;
    end
    end
end

v_log = log2(v);
y2_log = log2(y2);

plot(x,v_log,x1,y2_log);
title("Phase II image maximum variance statistic(orange line is UCL)")
xlabel("image number")
ylabel("log2(maximum variance statistic)")