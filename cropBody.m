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

THR_DIFF = 0.14;
color_diff = 0.15;

back = gaussian(back, 2, 5);
img = gaussian(img, 2, 5);

% directly use RGB gray value
% it is different to use which first, rgb2gray and abs ...
body = rgb2gray(abs((img - back))) > THR_DIFF ;
% subplot(2,2,3);
% imshow(body)

% using RGB 3 channel value
% body_log = abs(img - back) > color_diff;
% body = rgb2gray(double(body_log)) > 0.001;

% subplot(2,2,4);
% imshow(body)
% title('Result with filter');
% use canny edge detector maybe

end

