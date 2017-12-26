% make vedio

v = VideoWriter('res-3');
open(v);
for i = 1:1:463
    img = im2double(imread(strcat('results/',num2str(i),'.png')));
    writeVideo(v,img);
end
close(v)