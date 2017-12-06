function [ is_pass ] = isPass( body, mask )
%isPass Summary of this function goes here
%
% Draw the current state as a feedback to user.
%
% Input: 
% 	body: boolean. Matrix with size(1280*720). User's body.
% 	mask: boolean. Matrix with size(1280*720). The challange
%		  we proposed to the user.
%
% Output:
%	is_pass: bollean. Whether the player passed.
%

MATCH_RATIO = 0.95;
NUMBER_PART = 2;
%number part means how many part peter rong is devided.

is_pass = 0;
bbimg = getBondingImg(body,NUMBER_PART);
c =normxcorr2(mask,bbimg);
is_pass = c > MATCH_RATIO;

end
