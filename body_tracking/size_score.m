function [score] = size_score(size_1, size_2)
    if ((size_1/size_2) > 0.5) || ((size_1/size_2) < 2)
        score = 100;
        return;
    end
    % TODO update this to a linear function
    score = 0;
end