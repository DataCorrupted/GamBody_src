function [ mask, sklt_img, sklt_json ] = genMask()
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
files(idx+1, :)
sklt_json = readJsonFile(files(idx+1));
files(idx+2, :)
mask = imread(files(idx+2, :));
sklt_img = imread(files(idx+3, :));
end

