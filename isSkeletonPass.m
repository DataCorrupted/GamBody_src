function [ is_pass ] = isPass( body_path, mask_path )
%isPass Summary of this function goes here
%
% Draw the current state as a feedback to user.
%
% Input: 
% 	body_path: String. A path to body json file.
% 	mask_path: String. A path to mask json file.
%
% Output:
%	is_pass: bollean. Whether the player passed.
%

addpath('jsonlab');
jsonBody=loadjson(body_path);
jsonMask=loadjson(mask_path);
pirValBody=jsonBody.people{1, 1}.pose_keypoints;
pirValMask=jsonMask.people{1, 1}.pose_keypoints;
jsonvector1 = cell2mat(pirValBody);
jsonvector2 = cell2mat(pirValMask);
loss = 0;
count = 0;
if length(jsonvector1) ~= length(jsonvector2)
    is_pass = 0;
    len = 0;
else
    len = length(jsonvector1);
end
for i = 1:3:len
    if jsonvector1(i+2) >= 0.4 && jsonvector2(i+2) >= 0.4
        loss = loss + norm(jsonvector1(i:i+1)-jsonvector2(i:i+1));
        count = count + 1;
    end
end
if loss > 100 || count < 10
    is_pass = 0;
else
    is_pass = 1;
end

end