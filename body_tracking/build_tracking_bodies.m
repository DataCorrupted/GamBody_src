function [bodies_new] = build_tracking_bodies(img_RGB, back, bodies)
% given a set of image, build bodies containing all bodies

bodies_new = bodies;

% label where is bodies
[ body ] = cropBody(img_RGB, back );

idx = 1;
% while(1)
    [bbimg, position, flag] = getBondingImgRGB(body, img_RGB, idx);
    % img size
    ss = size(bbimg,1) * size(bbimg,2);
    % break when there is no other body or reach 10th image
%     if ((flag == 0) || (idx > 1) || (ss < 50))
%         break;
%     end
    % compute histogram
    colorhist = compute_histogram(bbimg);
%     corners = detect_features(bbimg);
    
    % create new body
    if (size(bodies_new,1) == 0)
        bodies_new = struct('colorhistogram',cell(1),...
        'size',[0 0],'positions',[0 0],'real',0,...
        'sample_id',1,...
        'img',cell(1),'score',cell(1));
        bodies_new.colorhistogram{1}=colorhist;
        % for test only
        % bodies_new.img{1} = bbimg;
    else
        % add initial features to the body
        bodies_new.colorhistogram{end+1}=colorhist;
        % for test only
        % bodies_new.img{end} = bbimg;
    end
    
    % idx = idx + 1;
% end

end