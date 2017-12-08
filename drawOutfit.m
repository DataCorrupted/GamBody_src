function [ ] = drawOutfit( judge, img, mask )
%drawOutfit Summary of this function goes here
%
% Draw the current state as a feedback to user.
%
% Input: 
%   judge: boolean. Whether the player succeed or not.
% 	img: double. Matrix with size(1280*720*3), image from camera.
% 	mask: boolean. Matrix with size(1280*720). The challange
%		  we proposed to the user.
%
% Output:
% 	redish / greenish img
%

% Should him fail, judge is 0 and we change red channel.
% Should him success, judge is 1 and we change green channel.
img(:, :, 1+judge) = ...
    uint8(double(img(:, :, 1+judge)) .* (1 + mask / 2));
% We change channel by making all pixel in the mask.
% Multiply by 1(out the mask) or 1.5(in the mask)

% % imshow(mask + body);
% % not effective
% I = mask + body;
% 
% % Try to draw the outfit of mask and body simultaneously
% % May not look good, need to adjust the UI later
% % edge_mask = edge(mask,'canny',0.1);
% 
% edge_body = edge(body,'canny',0.1);
% % Filtering to thicken the edges
% kernel = ones(7,7);
% edge_body = conv2(double(edge_body),kernel,'same') > 0;
% % edge_mask = conv2(double(edge_mask),kernel,'same') > 0;
% 
% if judge
%     % Show green body (maybe yellow mask?)
%     display = imoverlay(I,edge_body,'green');
%     % display = imoverlay(display,edge_mask,'yellow');
% else
%     % Show red body (maybe yellow mask?)
%     display = imoverlay(I,edge_body,'red');
%     % display = imoverlay(display,edge_mask,'yellow');
% end
% imshow(display);

end

