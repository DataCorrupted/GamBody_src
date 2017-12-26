function [ img ] = drawOutfit( judge, img, mask )
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
% 	img: redish / greenish img
%

% Should him fail, judge is 0 and we change red channel.
% Should him success, judge is 1 and we change green channel.

img(:, :, 1+judge) = img(:, :, 1+judge) .* (1 + double(mask) / 5);
% We change channel by making all pixel in the mask.
% Multiply by 1(out the mask) or 1.5(in the mask)

end

