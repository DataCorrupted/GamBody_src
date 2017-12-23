% I've write some comment for you guys.
% you can decomment the plot part but that will cost time.

clc;
clear all;
tic
back = im2double(rgb2gray((imread('../test_imgs/2.jpg'))));
data = im2double(rgb2gray((imread('../test_imgs/1.jpg'))));
% use gaussian filter to kill the edge response
% there will be edge response because of cam  shaking , when we do 
% subtracting there will be edges. but if we blur it, there will not be.
back = gaussian(back, 2, 5);
data = gaussian(data, 2, 5);
body = abs(data - back) > 0.14 ;  %this is body with shadow and noise.
								  %but we use thr = 0.14 so the image contain less shadow
imshow(bwareafilt(body,1)); % the biggest connected part 
body_with_head = bwareafilt(body,2); % the biggest two, this will contain head
body_without_head = bwareafilt(body,1);
bb = regionprops(body_without_head,'BoundingBox');
% bb is find the bounding box of the body.
% we should improve it to fit with multible part.
% index format is x y dx dy.
bb_index = bb.BoundingBox;
% bbimg is the bounding box image, which is small and faster to compute.
bbimg = body_without_head(bb_index(2):bb_index(2)+bb_index(4),bb_index(1):bb_index(1)+bb_index(3));
% we use normxcorr2 to normalize the bbimg and then get the corralation ratio.
% if the max value(the best match ratio) > 0.95(maybe other number), we treat this as a good match.
c =normxcorr2(bbimg,body_without_head);
max(c(:))
figure(1);
subplot(2,2,1);
imshow(data);
subplot(2,2,2);
imshow(body);
subplot(2,2,3);
imshow(back);
subplot(2,2,4);
imshow(body_with_head);
figure(2);
imshow(bbimg);

toc

% the total time for two image will be less than 1s. we still need to improve it.