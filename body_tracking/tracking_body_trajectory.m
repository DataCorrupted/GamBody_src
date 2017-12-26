function [bodies_new] = tracking_body_trajectory(img_RGB, back, bodies)
% given the objects in the bodies, update its new trajectory
% Input:
%       img_RGB:            3 channel double RGB image
%       back:               background images
% Output:
%       trajectories:    	A struct for saving the trajecctories

bodies_new = bodies;

% check the frame_id, if it is not 0, skip 
% Downsample the sampling rate
bodies_new.sample_id = bodies.sample_id + 1;
% if (mod(bodies.sample_id,2) == 1)
%     return;         % skip this frame
% end

% label where is bodies
[ body ] = cropBody(img_RGB, back );

% extract n people from the background
idx = 1;

% initialization
unmatched_colorhistogram = {};
unmatched_positions = {};
unmatched_size = {};
unmatched_imgs = {};
unmatched_left_corner = {};
unmatched_scores = [];
while(1)
    [bbimg, position, flag, left_corner] = getBondingImgRGB(body, img_RGB, idx);
    % img size
    ss = [size(bbimg,1) size(bbimg,2)];
    % filter out img_size < threshold
    if ((ss(1)*ss(2) < 700)||(idx >= 11))
        flag = 0;
    end
    % break when it is no other body or reach 10th image
    if ((flag == 0))
        if (idx == 1)
            create_tracking_image([], img_RGB, [0 0], bodies.sample_id)
            return;             % if no body detected in the image
        else
            break;              % find max-score in unmatched
        end
    end
    

    % compute histogram
    colorhist = compute_histogram(bbimg);
    
    % compute and weighted sum up all scores, for each body, it should get
    % a score
    scores = zeros(1,size(bodies.colorhistogram,2));
    
    if (bodies.real == 0)
        % for the first matching, give 50
        size_res = 50;
        position_res = 50;
    else
        % calculate the size score
        size_res = size_score(ss,bodies.size);
        % calculate the position score
        position_res = position_score(position,bodies.positions(end,:));
    end
    
    
    for i = 1:1:size(bodies.colorhistogram,2)
        scores(i) = scores(i) + size_res;
        scores(i) = scores(i) + position_res;
        scores(i) = scores(i) + histogram_score(colorhist,bodies.colorhistogram{i});
    end
    
    % check if the body match with any of the score
    [best_score, ~] = max(scores);
    if (best_score > 250)
        % imshow(bbimg);
        % update the person's colorhistgram (only update the last feature)
        bodies_new.colorhistogram{end} = colorhist;
        bodies_new.positions = [bodies.positions; position];
        bodies_new.size = ss;
        bodies_new.img{end+1} = bbimg;
        bodies_new.score{end+1} = best_score;
        bodies_new.real = 1;
        disp('person match entirely, breaking out');
        % create result vedio image
        create_tracking_image(bbimg, img_RGB, left_corner, bodies.sample_id);
        return;
    else
        % store everything need later to update the body
        % save the score and images for future comparsion
        unmatched_scores = [unmatched_scores best_score];
        unmatched_colorhistogram{end+1} = colorhist;
        unmatched_positions{end+1} = position;
        unmatched_size{end+1} = ss;
        unmatched_imgs{end+1} = bbimg;
        unmatched_left_corner{end+1} = left_corner;
        disp('person does not match, try next one');
    end
    
    % TODO extract feature of each body (try BRISK)
    
    idx = idx + 1;
end

% if not breaking out yet
% select the patch get the maximum score
[best_score, best_i] = max(unmatched_scores);
% if miss-match
if (best_score < 80)
    % miss-match
    disp('miss-match')
    return;
end
% update the body
bodies_new.colorhistogram{end} = unmatched_colorhistogram{best_i};
bodies_new.positions = [bodies.positions; unmatched_positions{best_i}];
bodies_new.size = unmatched_size{best_i};
bodies_new.img{end+1} = unmatched_imgs{best_i};
bodies_new.score{end+1} = unmatched_scores(best_i);
bodies_new.real = 1;
disp('person matched');
create_tracking_image(unmatched_imgs{best_i}, img_RGB,...
    unmatched_left_corner{best_i}, bodies.sample_id);
end