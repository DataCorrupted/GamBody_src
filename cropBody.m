function [ body ] = cropBody( img, back )
%cropBody Summary of this function goes here
%
% Given an image, tell where the player's body is.
%
% Input: 
%   img: double. Matrix with size(1024*768*3)
%   back: double. Matrix with size(1024*768*3), background.
%
% Output:
% 	body: boolean. Matrix with size(1024*768), where 1 means 
%		  this pixel is body.
%
body = zeros(size(img));

end

