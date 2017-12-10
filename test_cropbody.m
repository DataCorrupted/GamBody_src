% For testing the performance of cropbody only
img = im2double(imread('test_imgs/1.jpg'));
back = im2double(imread('test_imgs/2.jpg'));

subplot(2,2,1);
imshow(img);
title('Image containing body')
subplot(2,2,2);
imshow(back);
title('Background')

subplot(2,2,3);
imshow(abs(img-back));
title('Direct minus');

body = cropBody( img, back );
