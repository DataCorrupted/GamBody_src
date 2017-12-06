function [  ] = drawOutfit( judge, body, mask )
%drawOutfit Summary of this function goes here
%
% Draw the current state as a feedback to user.
%
% Input: 
%   judge: boolean. Whether the player succeed or not.
% 	img: uint8. Matrix with size(1280*720), image from camera.
% 	mask: boolean. Matrix with size(1280*720). The challange
%		  we proposed to the user.
%
% Output:
% 	redish / greenish img
%

% Should him fail, judge is 0 and we change red channel.
% Should him success, judge is 1 and we change green channel.
% img(:, :, 1+judge) = ...
%     uint8(double(img(:, :, 1+judge)) .* (1 + mask / 2));
% We change channel by making all pixel in the mask.
% Multiply by 1(out the mask) or 1.5(in the mask)

% imshow(mask + body);
% not effective
I = mask + body;
edges = edge(body,'canny',0.1);
if judge
    % Show green light
    % very thin, have to update
    display = imoverlay(I,edges,'green');
else
    % Show red light
    display = imoverlay(I,edges,'red');
end
imshow(display);

end

