function [vector] = readJsonFile(jsonform)
addpath('jsonlab');
json=loadjson(jsonform);
[~,peopleCount] = size(json.people)
vector = zeros(3,18,peopleCount);
for i = 1:peopleCount
    pirVal=json.people{1, i}.pose_keypoints;
    vector(:,:,i) = reshape(cell2mat(pirVal),3,18);
end
