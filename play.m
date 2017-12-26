% play
for i = 1:1:size(bodies.img,2)
    % imshow(bodies.img{i});
    img_RGB = imresize(im2double(imread(strcat('data/',num2str(i),'.png'))),0.5,'nearest');
    create_tracking_image(bodies.img{i}, img_RGB, bodies.positions(i+1,:), i)
end