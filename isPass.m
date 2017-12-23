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

% MATCH_RATIO = 0.70;
% NUMBER_PART = 2;
% % number part means how many part peter rong is devided.
% try
%     bbimg = getBondingImg(body, NUMBER_PART);
%     c = normxcorr2(bbimg, mask);
%      max(c(:)) 
%     is_pass = max(c(:)) > MATCH_RATIO;
% catch 
%     is_pass = 0;
% end

addpath('jsonlab');
jsonBody=loadjson(body);
jsonMask=loadjson(mask);
pirValBody=jsonBody.people{1, 1}.pose_keypoints;
pirValMask=jsonMask.people{1, 1}.pose_keypoints;
jsonvertor1 = cell2mat(pirValBody);
jsonvertor2 = cell2mat(pirValMask);
error = 0;
count = 0;
for i = 1:3:48
    if jsonvertor1(i+2) >= 0.4 && jsonvertor2(i+2) >= 0.4
        error = error + norm(jsonvertor1(i:i+1)-jsonvertor2(i:i+1));
        count = count + 1;
    end
end
if error > 100 || count < 10
    is_pass = 0;
else
    is_pass = 1;
end

