function [ is_pass ] = isSkeletonPass( body, mask )
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


loss = 0;
count = 0;
% Suppose size(mask) is same
[~,points,peopleCount] = size(body);
for i = 1:peopleCount
    man = body(:,:,i);
    mask = mask(:,:,i);
    for j = 1:points
        if body(3,j) >= 0.4 && mask(3,j) >= 0.4
            loss = loss + norm(body(1:2,j)-mask(1:2,j));
            count = count + 1;
        end
    end
end
if loss > 100 || count < 10
    is_pass = 0;
else
    is_pass = 1;
end

end