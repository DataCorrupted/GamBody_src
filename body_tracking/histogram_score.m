function [score] = histogram_score(V1,V2)
% take a bonding image as input, a body as the output
% Input:
%       V1:             the histogram from image 1
%       V2:             the histogram from image 2
% Output:
%       score:          A score (0-100) higher means similar

    % normalize histogram first
    V1 = V1/norm(V1,1) * 100;
    V2 = V2/norm(V2,1) * 100;
    
    res = 0;
    % compare two histogram, and count how many bin they are the same
    for i = 1:1:size(V1,1)
        res = res + min([V1(i) V2(i)]);
    end
    
    % rescale the score from 0-100 to 0-100 (em... no rescaling here)
    score = res;
end