function [ body_path ] = getSkeleton( img )
%getSkeleton Summary of this function goes here
%
% Given an image, output a json file of it's key points,
% along with key points' path
%
% Input: 
% 	img: double. Matrix with size(1280*720). Image from camera stream.
%
% Output:
%	body_path: string.
%
imwrite(img,'tmp\img.jpg');

%% Use Openpose here.
%!bin\OpenPoseDemo.exe --image_dir tmp\ --write_keypoint_json tmp\ --no_display
body_path = 'tmp\img_keypoints.json';
end
