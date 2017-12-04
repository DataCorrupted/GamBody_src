clc;
clear all;
tic
back = im2double(rgb2gray((imread('../test_imgs/2.jpg'))));
data = im2double(rgb2gray((imread('../test_imgs/1.jpg'))));

back = gaussian(back, 2, 5);
data = gaussian(data, 2, 5);
% figure(1);
% subplot(2,2,1);
% imshow(data);
body = abs(data - back) > 0.14 ;
% subplot(2,2,2);
% imshow(body);
imshow(bwareafilt(body,1));
body2 = bwareafilt(body,2);
body_without_head = bwareafilt(body,1);
bb = regionprops(body_without_head,'BoundingBox');
bb_index = bb.BoundingBox;
% bbimg is the bounding box image, which is small and faster to compute.
bbimg = body_without_head(bb_index(2):bb_index(2)+bb_index(4),bb_index(1):bb_index(1)+bb_index(3));
c =normxcorr2(bbimg,body_without_head);
max(c(:))
subplot(2,2,3);
imshow(back);
subplot(2,2,4);
imshow(body);
figure(2);
imshow(body);

toc