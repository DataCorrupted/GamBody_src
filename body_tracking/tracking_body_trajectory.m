function [bodies_new] = tracking_body_trajectory(img_RGB, back, bodies)
% given the objects in the bodies, update its new trajectory
% Input:
%       img_RGB:            3 channel double RGB image
%       back:               background images
% Output:
%       trajectories:    	A struct for saving the trajecctories

% initialization
bodies_new = bodies;
matched_idx = zeros(size(bodies,2));

% figure;
% imshow(img_RGB);
% figure;
% imshow(back);

% label where is bodies
[ body ] = cropBody(img_RGB, back );
% figure;
% imshow(body);

% extract n people from the background
idx = 1;
while(1)
    [bbimg, position, flag] = getBondingImgRGB(body, img_RGB, idx);
    % img size
    ss = size(bbimg,1) * size(bbimg,2);
    % break when it is no other body or reach 10th image
    if ((flag == 0) || (idx > 10) || (ss < 50))
        break;
    end

    % compute histogram
    colorhist = compute_histogram(bbimg);
    
    % compute and weighted sum up all scores, for each body, it should get
    % a score
    scores = zeros(1,size(bodies,2));
    for i = 1:1:size(bodies,2)
        if (matched_idx == 0)
            
            % size score
            if (bodies{i}.real == 0)
                % just trained, didn't have real size info
                scores(i) = scores(i) + 50;
            else
                scores(i) = size_score(ss,bodies{i}.size);
            end
            
            % hostigram score
            scores(i) = scores(i) + histogram_score(colorhist,bodies{i}.colorhistogram);
        end
    end
    
    % match it with bodies in the last iteration, update the position
    [best_score, best_i] = max(scores);
    if ((isempty(best_i) == 1))
        continue;
    end
    
    % update bodies
    if (best_i == 0)
        disp('unidentified object found');
    else
        % save the color histogram as a new histogram
        bodies_new{best_i}.colorhistogram = colorhist;
        bodies_new{best_i}.positions = [bodies{best_i}.positions; position];
        bodies_new{best_i}.size = ss;
        bodies_new{best_i}.img{end+1} = bbimg;
        bodies_new{best_i}.score{end+1} = best_score;
        disp('tracking person')
        break;
    end
    
    % TODO extract feature of each body (try BRISK)
    
    idx = idx + 1;
end
end