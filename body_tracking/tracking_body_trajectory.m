function [bodies_new] = tracking_body_trajectory(img_RGB, back, bodies)
% given the objects in the bodies, update its new trajectory
% Input:
%       img_RGB:            3 channel double RGB image
%       back:               background images
% Output:
%       trajectories:    	A struct for saving the trajecctories

% figure;
% imshow(img_RGB);
% figure;
% imshow(back);

bodies_new = bodies;

% label where is bodies
[ body ] = cropBody(img_RGB, back );
% figure;
% imshow(body);

% extract n people from the background
idx = 1;
while(1)
    [bbimg, position, flag] = getBondingImgRGB(body, img_RGB, idx);
    % img size
    ss = [size(bbimg,1) size(bbimg,2)];
    % break when it is no other body or reach 10th image
    if ((flag == 0) || (idx > 10) || (ss(1)*ss(2) < 700))
        break;
    end

    % compute histogram
    colorhist = compute_histogram(bbimg);
    
    % compute and weighted sum up all scores, for each body, it should get
    % a score
    scores = zeros(1,size(bodies.colorhistogram,2));
    % calculate the size score
    if (bodies.real == 0)
        % for the first matching, give 50
        size_res = 50;
    else
        size_res = size_score(ss,bodies.size);
    end
    
    for i = 1:1:size(bodies.colorhistogram,2)
        scores(i) = scores(i) + size_res;
        scores(i) = scores(i) + histogram_score(colorhist,bodies.colorhistogram{i});
    end
    
    % check if the body match with any of the score
    [best_score, best_i] = max(scores);
    if ((isempty(best_i) == 1) || (best_score < 100))
        disp('person does not match, try next one');
    else
        imshow(bbimg);
        % update the person's colorhistgram (only update the last feature)
        bodies_new.colorhistogram{end} = colorhist;
        bodies.positions = [bodies.positions; position];
        bodies_new.size = ss;
        bodies_new.img{end+1} = bbimg;
        bodies_new.score{end+1} = best_score;
        bodies_new.real = 1;
        disp('tracking person');
        break;
    end
    
    % TODO extract feature of each body (try BRISK)
    
    idx = idx + 1;
end
end