function [ img ] = readImg(  )
%readImg Summary of this function goes here
%
% Load data from camera streaming, resize it to 1280*720.
%
% Input: 
%	None
%
% Output:
% 	img: double, matrix with size(1280*720*3), all data should 
%		 range from 0 to 1. 
%

cam_cnt = length(webcamlist);
if cam_cnt == 0
    error('test error');
end
cam = webcam;
% No option for 1280*720, we may want to discuss this later.
cam.Resolution = '1280x720';
img = snapshot(cam);
img = im2double(img);
imshow(img);

end

