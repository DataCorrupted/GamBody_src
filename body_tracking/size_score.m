function [score] = size_score(size_1, size_2)
    lower_thres = 0.75;
    higher_thres = 1.25;
    if ((size_1(1)/size_2(1)) > lower_thres) &&...
            ((size_1(1)/size_2(1)) < higher_thres) &&...
            ((size_1(2)/size_2(2)) > lower_thres) &&...
            ((size_1(2)/size_2(2)) < higher_thres)
        score = 100;
        return;
    end
    % TODO update this to a linear function
    score = 25;
end