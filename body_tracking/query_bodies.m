function [ player_position ] = query_bodies( bodies, img,  poses )
% query the player's position from the given positions
% Input:
%       bodies:             the bodies struct used for tracking
%       img:                the last image (used for matching), usless now
%       positions:          the positions for all human (18*3*n)
% Output:
%       player_position:    the position for the player


min_dist = -1;
min_i = 0;
for i = 1:1:size(poses,3)
    % get the center point
    center = get_center_position(poses(:,:,i));
    dist = norm(bodies{i}.positions(end,:)'-center);
    if ((min_dist == -1) || (dist < min_dist))
        min_dist = dist;
        min_i = i;
    end
end

player_position = poses(:,:,min_i);

end

function [center] = get_center_position(pos_in)
    % get the center position 
    % Input:
    %       pos             3*18*1 matrix
    % Output:
    %       center:         1*2 matrix
    pos = pos_in(1:2,:)';
    center = mean(pos);
end