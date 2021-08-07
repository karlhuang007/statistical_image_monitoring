imagefiles = dir('*.jpg');      
nfiles = length(imagefiles);    % Number of files found
test_result = [];
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

for i=1:22
    variance_single =max_variance_of_pic(sprintf('b%d.jpg',i));
    v = [v,variance_single];

end


for i=1:98
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

plot(x,v,x1,y2);
title("Phase II image statistic(orange line is UCL = 82.30)")
xlabel("image number")
ylabel("T2 statistic")