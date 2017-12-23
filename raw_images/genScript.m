addpath('..');
files = ls;
B = double(imread(files(3, :))) / 256;
for i= 4:length(files)
end
for i= 4:4
    I = double(imread(files(i, :))) / 256;
    [mask, bb] = genMaskFromImg(I, B);
    path = strcat(files(i, 1:25), '_mask.jpg');
    imwrite(mask, path);
end