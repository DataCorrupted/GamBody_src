function [ mask ] = genMask(  )
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

mask = zeros(720, 1280);
mask(100:400, 200:500) = 1;
end

