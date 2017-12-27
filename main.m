function [ ] = main( critical_time )
%main Summary of this function goes here
%
% There is no main function is MATLAB, but having one is better.
% Do real-time webcam processing and displaying
%
% Input: 
%   critical_time: how much time you have for preparation. By
%                  default it's 10.
%
% Output:
%   None
%
if nargin == 0
    critical_time = 10;
end
% the image acquisition hardware is reset
imaqreset
% The parameters may differ for different OS and OEM.
% Run "imaqhwinfo" to check if you have 'winvideo' installed. ( Or on other
% platform, Mac should be 'macvideo')
% Run "imaqhwinfo('winvideo')", you will see a field called "DeviceInfo"
% Check "DeviceInfo" you will see it containing a field "SupportedFormats"
% list them and pick one for your computer. 
% (We use JPEG1280x720 resolution by default.)
imafo = imaqhwinfo;
adaptor = imafo(1).InstalledAdaptors{1};
adapinfo = imaqhwinfo(adaptor,1);
% In Peter's computer the first one format is 1280*720.
formats = adapinfo.SupportedFormats{1};
obj = videoinput(adaptor, 1, formats);
try
    % Initialize various parameters, and load in the template data
    set(obj, 'framesperTrigger', 10, 'TriggerRepeat', Inf);
    start(obj);
    
    % h is a handle to the canvas
    h = imshow(zeros(720,1280));
    hold on;
    tic
    % Capturing and displaying the processed image during the run time of
    % the camera
    [mask, sklt_img, sklt_vec] = genMask();
    judge = -1;
    show_time = 2;		% 2s
    while islogging(obj)
        if toc < critical_time
            % Read a image from camera stream
            img = double(getdata(obj,1)) / 255;
            % Mirror
            img = flip(img, 2);
            show_img = drawOutfit(2, img + sklt_img, mask);       
        else
        if toc < show_time + critical_time && judge == -1
            % Make a judge or show the result.
            body_path = getSkeleton(img);
            body = readJsonFile(body_path);
            judge = isSkeletonPass(body, sklt_vec);
            show_img = drawOutfit(judge, img, mask);
        else
            % A new level of game
            showMsg(judge);
            [mask, sklt_img, sklt_vec] = genMask();
            judge = -1;
            tic
        end
        end
        %% Drawing
        % Image processing part goes here
        % Remove all logged data records associated with object
        flushdata(obj);
        % This is what paints on the canvas
        set(h, 'Cdata', show_img);
        drawnow;
    end

catch err
    % This attempts to take care of things when the figure is closed
    stop(obj);
    delete(obj);
    % the image acquisition hardware is reset
    imaqreset
    disp('Cleaned up')
    rethrow(err);
end