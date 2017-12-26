function [ bondingImg, position, flag ] = getBondingImgRGB(img_bool, img_rgb , number)
% Get the bounding box for the ith body. Suppose each body is one componment.
% Input: 
%       img_bool:           The bool image containing all bodies
%       img_rgb:            The RGB image
%       number:             The ith body want to extract
% Output:
%       bondingImg:         The bonding RGB image
%       position:           The 2D position
%       flag:               success (true)

% the biggest two, this will contain head
if (number == 1)
    body_with_head = bwareafilt(img_bool, number);
else
    body_with_head = bwareafilt(img_bool, number) - bwareafilt(img_bool, number-1);
end

if (max(max(body_with_head)) == 0)
    bondingImg = [];
    position = [];
    flag = 0;
    return;
end

bb = regionprops(body_with_head, 'BoundingBox');
% bb is find the bounding box of the body.
% improved it to fit with multible part.
% index format is x y dx dy.
% Peter: add a min len(bb) in case we have less regions than we expected,
% which is a good sign, but we don't want to crush the program
bb_index = getBB(bb, min(length(bb), number));

% bbimg is the bounding box image, which is small and faster to compute.
bbcolor = img_rgb(bb_index(2):bb_index(4),bb_index(1):bb_index(3),1:3);

bondingImg = bbcolor;
position = [(bb_index(2)+bb_index(4))/2 (bb_index(1)+bb_index(3))/2];

flag = 1;

function bb_index  = getBB(bb,n)
    temp = zeros(n,4);
    for i = 1:n
        temp(i,:) = bb(i).BoundingBox;
        temp(i,3) = temp(i,1)+temp(i,3);
        temp(i,4) = temp(i,2)+temp(i,4);
    end
    bb_index = ...
        floor([min(temp(:,1)),min(temp(:,2)),max(temp(:,3)),max(temp(:,4))]);
    bb_index(bb_index == 0) = 1;
end

end 