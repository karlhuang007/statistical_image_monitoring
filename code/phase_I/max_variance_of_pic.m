function [max_variance_among_slideing_windows] = max_variance_of_pic(image)
%UNTITLED This function return the maximal variance among all 10*10 moving
% windows of the input image

% g1 = rgb2gray(imread(image));
g1 = im2gray(imread(image));
% g1 = image;
defekt_variance=[];

[x,y] = size(g1);

for i = 1 : (floor(x/10))
    for j = 1: (floor(y/10))
        moving_windows = g1(((i-1)*10 +1) : i*10 , ((j-1)*10 +1) : j*10);
          
        row_vector = reshape(moving_windows,1,[]);
        A = cast(row_vector, 'double');
        % calculate the variance of grey value in moving windows
        a = var(A);
        defekt_variance = [defekt_variance,a];
         
    end
end
max_variance_among_slideing_windows = max(defekt_variance);

end



