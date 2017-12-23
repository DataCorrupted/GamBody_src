function [trajectories_new] = update_body_trajectory(img_RGB, back, trajectories)
% extract each one from the image pose
% Input:
%       img_RGB:            3 channel double RGB image
%       back:               background images
% Output:
%       trajectories:    	A struct for saving the trajecctories

if (trajectories == 0)
    trajectories = struct('colorhistogram',cell(1),'positions',cell(1));
end

% parameters (TODO maybe consider image size here)
threshold = 

% extract n people from the background
[ body ] = cropBody(img_RGB, back );
img_gray = rgb2gray(img_RGB);
idx = 1;
while(1)
    if (idx == 1)
        [bbimg, position] = getBondingImgGray(body, img_RGB, idx);
    else
    % get the second largetest body:
    % 2th body = the two largest bodies - the largest body
    % TODO, change the way to get bodies
        [bbimg, position] = getBondingImgGray(body, img_RGB, idx) - getBondingImgGray(body, img_RGB, idx-1);
        % break when it is all 0
        if (min(min(bbimg)) == 0)
            break;
        end
    end

    % compute histogram
    V = compute_histogram(bbimg);
    % check it with bodies in the last iteration, update the position
    matched_flag = 0;
    for i = 1:1:size(trajectories.colorhistogram,1)
        [res] = compare_histogram(V, trajectories.colorhistogram{i});
        if (res > threshold)
            % save the color histogram as the new histogram
            trajectories_new.colorhistogram{i} = V;
            trajectories_new.positions{i} = position;
            matched_flag = 1;
            break;
        end
    end
    if (matched_flag == 0)
        trajectories_new.colorhistogram{end+1} = V;
        trajectories_new.positions{i} = position;
    end
    
    % TODO extract feature of each body (try BRISK)
    

end
end
function [V] = compute_histogram(img)
    % compute the color histogram of the image
    
    % 4 * 4 * 4
    V = zeros(64,1);
    
    m = size(img,1);
    n = size(img,2);
    for i = 1:1:m
        for j = 1:1:n
            index = 16 * img(i,j,1)/64 + 4 * img(i,j,2)/64 + img(i,j,3)/64 + 1;
            V(index) = V(index) + 1;
        end
    end
end

function [res] = compare_histogram(V1, V2)
    % compare two histogram, and count how many bin they are the same
    for i = 1:1:size(V1,1)
        res = res + min([V1(i) V2(i)]);
    end
end