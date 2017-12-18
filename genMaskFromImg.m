function [ mask ,bbmask ] = genMaskFromImg(img,back)
%genMask Summary of this function goes here
%
% Draw the current state as a feedback to user.
%
% Input: 
%	img,back
%
% Output:
% 	mask: boolean. Matrix with size(1280*720). The challange
%		  we proposed to the user.
% 	bbmask : a bonding mask, smaller than mask

NUMBER_PART = 2;

mask = cropBody(img,back);

bbmask = getBondingImg(mask,NUMBER_PART);

end

