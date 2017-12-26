function [bodies_new] = build_tracking_bodies(img_RGB, back, bodies)
% given a set of image, build bodies containing all bodies

bodies_new = bodies;

% label where is bodies
[ body ] = cropBody(img_RGB, back );

idx = 1;
while(1)
    [bbimg, position, flag] = getBondingImgRGB(body, img_RGB, idx);
    % img size
    ss = size(bbimg,1) * size(bbimg,2);
    % break when there is no other body or reach 10th image
    if ((flag == 0) || (idx > 10) || (ss < 50))
        break;
    end
    
    % compute histogram
    colorhist = compute_histogram(bbimg);
    
    % create new body
    bodies_new{end+1} = struct('colorhistogram',colorhist,...
        'size',ss,'positions',[0 0],'real',0,...
        'img',cell(1),'score',cell(1));
    % for test only
    bodies_new{end}.img{1} = bbimg;
    bodies_new{end}.score{1} = 0;
    
    idx = idx + 1;
end

end