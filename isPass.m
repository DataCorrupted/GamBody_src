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
cover = body & mask;
is_pass = (sum(cover(:)) / sum(body(:)) > .95);

end

