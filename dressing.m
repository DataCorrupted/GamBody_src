function [dressed_img] = dressing(sklt_vector)
cloth = im2double(imread('raw_images/cloth.jpg'));
[hc, wc, ~] = size(cloth);
skirt = im2double(imread('raw_images/skirt2.jpg'));
[hs, ws, ~] = size(skirt);
dressed_img = zeros(720,1280,3);
peopleCount = size(sklt_vector, 3);
for i = 1 : peopleCount
    neck = sklt_vector(:,2,i);
    waist = sklt_vector(:,9,i);
    height = floor(waist(2) - neck(2));
    scale_cloth = height / hc;
    cloth = imresize(cloth, scale_cloth*1.5);
    [newhc, newwc, ~] = size(cloth);
    border_x = floor(neck(1) - newwc/2);
    border_y = floor(neck(2)) - 45;
    dressed_img(border_y:border_y+newhc-1, border_x:border_x+newwc-1, :) = cloth;
    
    right_waist = sklt_vector(:,12,i);
    width = floor(right_waist(1) - waist(1)) * 2.1;
    scale_skirt = width / ws;
    skirt = imresize(skirt, scale_skirt*1.5);
    [newhs, newws, ~] = size(skirt);
    bor_x = floor( (right_waist(1) + waist(1)) / 2 - newws/2 );
    bor_y = border_y+newhc-20;
    dressed_img(bor_y:bor_y+newhs-1, bor_x:bor_x+newws-1, :) = skirt;
end