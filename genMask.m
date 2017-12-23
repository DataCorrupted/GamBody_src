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
idx = (idx - 1) * 3 + 2;
sklt_vec = readJsonFile(strcat('masks/', files(idx+1).name));
mask = imread(strcat('masks/', files(idx+2).name));
sklt_img = imread(strcat('masks/', files(idx+3).name));
end

