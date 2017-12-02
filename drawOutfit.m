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
imshow(mask + body);
if judge
    % Show green light
else
    % Show red light
end

end

