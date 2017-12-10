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
% body = abs(rgb2gray((img - back))) > THR_DIFF ;

% using RGB 3 channel value
body_log = abs(im2double(img) - im2double(back)) > color_diff;
body = rgb2gray(double(body_log)) > 0.001;

% use canny edge detector maybe

% use HSV
% img_hsv = rgb2hsv(img);
% back_hsv = rgb2hsv(img);
% body = abs(img_hsv - back_hsv) > 0.01;
% imshow(hsv2rgb(body));

% maybe use some filter to connect nearby inconnect components

end

