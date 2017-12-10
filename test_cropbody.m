% For testing the performance of cropbody only
img = im2double(imread('test_imgs/1.jpg'));
back = im2double(imread('test_imgs/2.jpg'));

subplot(2,2,1);
imshow(img);
subplot(2,2,2);
imshow(back);

subplot(2,2,3);
res = abs(img - back);
imshow(res);

body = cropBody( img, back );

subplot(2,2,4);
imshow(body);