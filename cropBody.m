function [ body ] = cropBody( img, back )
%cropBody Summary of this function goes here
%
% Given an image, tell where the player's body is.
%
% Input: 
%   img: double. Matrix with size(1280*720*3)
%   back: double. Matrix with size(1280*720*3), background.
%
% Output:
% 	body: boolean. Matrix with size(1280*720), where 1 means 
%		  this pixel is body.
%

% I don't know which color you use, I think HSV will be better.
THR_DIFF = 0.14;

body = zeros(size(img));
back = gaussian(back, 2, 5);
img = gaussian(img, 2, 5);
body = abs(img - back) > THR_DIFF ;
end

