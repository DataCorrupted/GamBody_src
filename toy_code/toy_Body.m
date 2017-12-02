clc;
clear all;
tic
back = im2double(rgb2gray((imread('../test_imgs/2.jpg'))));
data = im2double(rgb2gray((imread('../test_imgs/1.jpg'))));
back = gaussian(back, 2, 5);
data = gaussian(data, 2, 5);
figure(1);
subplot(2,2,1);
imshow(data);
body = abs(data - back) > 0.14 ;
subplot(2,2,2);
imshow(body);

body = bwareafilt(body,2);
subplot(2,2,3);
imshow(back);
subplot(2,2,4);
imshow(body);
toc
