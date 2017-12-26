% show tracking results
idx = 11;
imgs = bodies{idx}.img;
for i = 1:1:size(imgs,2)
    imshow(imgs{i})
end