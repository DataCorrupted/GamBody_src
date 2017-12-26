% play 3 (testing tracking certain number of person)
addpath('body_tracking');
mkdir('results');
tic;
bodies = {};
back = im2double(imread('training/back.png'));
% back = imresize(back,0.5);

for i = 1:1:17
    % training_RGB = imresize(im2double(imread(strcat('training/',num2str(i),'.png'))),0.5,'nearest');
    training_RGB = im2double(imread(strcat('training/',num2str(i),'.png')));
    [bodies] = build_tracking_bodies(training_RGB, back, bodies);
end

return;
for i = 1:1:464
    if (i >= 231)
        debug = 1;
    end
    % img_RGB = imresize(im2double(imread(strcat('data/',num2str(i),'.png'))),0.5,'nearest');
    img_RGB = im2double(imread(strcat('data/',num2str(i),'.png')));
    [bodies] = tracking_body_trajectory(img_RGB, back, bodies);
    disp(i);
end
toc;