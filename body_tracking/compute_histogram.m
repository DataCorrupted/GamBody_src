function [V] = compute_histogram(img)
    % compute the color histogram of the image
    
    % 4 * 4 * 4
    V = zeros(64,1);
    
    m = size(img,1);
    n = size(img,2);
    for i = 1:1:m
        for j = 1:1:n
            index = floor(16 * img(i,j,1)*3 + 4 * img(i,j,2)*3 +...
                img(i,j,3)*3) + 1;
            V(index) = V(index) + 1;
        end
    end
end