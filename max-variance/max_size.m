function [max_variance_among_slideing_windows] = max_size(image,s)
%UNTITLED This function return the maximal variance among all 10*10 moving
% windows of the input image

g1 = rgb2gray(imread(image));

defekt_variance=[];

[x,y] = size(g1);

for i = 1 : (floor(x/s))
    for j = 1: (floor(y/s))
        moving_windows = g1(((i-1)*s +1) : i*s , ((j-1)*s +1) : j*s);
          
        row_vector = reshape(moving_windows,1,[]);
        A = cast(row_vector, 'double');
        % calculate the variance of grey value in moving windows
        a = var(A);
        defekt_variance = [defekt_variance,a];
         
    end
end
max_variance_among_slideing_windows = max(defekt_variance);

end

