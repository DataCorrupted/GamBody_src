function [ mask ] = genMask()
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

mask_cnt = 5;
idx = randi(mask_cnt);
pat = strcat('masks/mask', num2str(idx), '.jpg');
mask = imread(pat);
% subplot(121); imshow(mask);
mask = mask > 200;
% subplot(122); imshow(mask);
end

