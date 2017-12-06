function [  ] = drawOutfit( judge, body, mask )
%drawOutfit Summary of this function goes here
%
% Draw the current state as a feedback to user.
%
% Input: 
%   judge: boolean. Whether the player succeed or not.
% 	body: boolean. Matrix with size(1280*720). User's body.
% 	mask: boolean. Matrix with size(1280*720). The challange
%		  we proposed to the user.
%
% Output:
% 	None
%
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

