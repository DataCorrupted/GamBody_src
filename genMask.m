function [ mask, sklt_img, sklt_vec ] = genMask()
%genMask Summary of this function goes here
%
% Draw the current state as a feedback to user.
%
% Input: 
%	None
%
% Output:
% 	mask: boolean. Matrix with size(1280*720). The challange
%		  we proposed to the user.
%

mask_cnt = 8;
idx = randi(mask_cnt);
files = dir('masks');
% The first 2 files is . and .., then we have 3 files for each mask.
idx = (idx - 1) * 3 + 2;
sklt_vec = readJsonFile(strcat('masks/', files(idx+1).name));
mask = imread(strcat('masks/', files(idx+2).name));
sklt_img = imread(strcat('masks/', files(idx+3).name));
% Have to rescale it to [0, 1]
sklt_img = double(sklt_img) / 256;
end

