function [corners] = detect_features(bbimg)
% Take a bbimg as input, detect features

corners = detectFASTFeatures(bbimg);
imshow(bbimg); hold on;
plot(corners.selectStrongest(50));

end

