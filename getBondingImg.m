function [ bondingImg ] = getBondingImg(img,number)

body_with_head = bwareafilt(body,number); % the biggest two, this will contain head
bb = regionprops(body_with_head,'BoundingBox')
% bb is find the bounding box of the body.
% improved it to fit with multible part.
% index format is x y dx dy.
bb_index = getBB(bb,number);
% bbimg is the bounding box image, which is small and faster to compute.
bbimg = body_with_head(bb_index(2):bb_index(4),bb_index(1):bb_index(3));

bondingImg = bbimg;

function bb_index  = getBB(bb,n)
	temp = zeros(n,4);
	for i = 1:n
		temp(i,:) = bb(i).BoundingBox;
        temp(i,3) = temp(i,1)+temp(i,3);
        temp(i,4) = temp(i,2)+temp(i,4);
    end
	bb_index = [min(temp(:,1)),min(temp(:,2)),max(temp(:,3)),max(temp(:,4))];
end

end	