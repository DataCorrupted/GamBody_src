function [ ] = main( levels, critical_time )
%main Summary of this function goes here
%
% There is no main function is MATLAB, but having one is better.
%
% Input: 
%   levels: the total levels you want to play.
%   critical_time: how much time you have for preparation.
%
% Output:
% 	None
%

% calibrate();

% Load the background before hand.
back = readImg();

t = 0;
while t < levels
	t = t + 1;
	% Randomly generate(Take ) mask.
	% MAKE IT REASONABLE!
	mask = genMask();

	% Start counting time
	tic
	while toc <= critical_time
		% From camera stream get data.
		img = readImg();
		% Find body region.
		body = cropBody(img, back);
		% Make sure if success
		judge = isPass(body, mask);
		%drawOutfit: if success, draw green outfit, else red
		drawOutfit(judge, body, mask);
	end
	showMsg(judge);
	% Failed, return.
	if ~judge
		break
	end
end



end

