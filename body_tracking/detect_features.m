function [points] = detect_features(bbimg)
% Take a bbimg as input, detect features
grayimg = rgb2gray(bbimg);

% corners = detectFASTFeatures(grayimg);
% mkdir('fast-results');
% figure;
% imshow(grayimg); hold on;
% plot(corners.selectStrongest(50));
% hold off;

points = detectBRISKFeatures(grayimg);
imshow(grayimg); hold on;
plot(points.selectStrongest(10));

end

