function create_tracking_image(bbimg, img, left_corner, frame_id)

disp(strcat('frame_id=',num2str(frame_id)));

filename = strcat('results/',num2str(frame_id),'.png');

% empty bbimg
if (size(bbimg,1) == 0)
    img(:,:,:) = img(:,:,:);
else

height = size(bbimg,1)-1;
width = size(bbimg,2)-1;
left_top = left_corner;
right_bottom = [left_top(1)+height left_top(2)+width];

% highlight the bounding box
img(left_top(1):right_bottom(1),left_top(2):right_bottom(2),:) = ...
    img(left_top(1):right_bottom(1),left_top(2):right_bottom(2),:)...
    * 2;
% darken other image
img = min(img,1);

end

imshow(img);
imwrite(img,filename);

end

