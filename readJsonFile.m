function [vector] = readJsonFile(jsonform)
addpath('jsonlab');
json=loadjson(jsonform);
pirVal=json.people{1, 1}.pose_keypoints;
vector = reshape(cell2mat(pirVal),3,18);

