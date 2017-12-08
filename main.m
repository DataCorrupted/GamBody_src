%function [ ] = main( critical_time )
%main Summary of this function goes here
%
% There is no main function is MATLAB, but having one is better.
% Do real-time webcam processing and displaying
%
% Input: 
%   critical_time: how much time you have for preparation.
%
% Output:
% 	None
%
critical_time = 3;
% the image acquisition hardware is reset
imaqreset
% The parameters may differ for different OS and OEM.
% Run "imaqhwinfo" to check if you have 'winvideo' installed. ( Or on other
% platform, Mac should be 'macvideo')
% Run "imaqhwinfo('winvideo')", you will see a field called "DeviceInfo"
% Check "DeviceInfo" you will see it containing a field "SupportedFormats"
% list them and pick one for your computer. 
% (We use 1280x720 resolution by default.)
% Since camera is device dependent, each computer can have different value.
% For Peter(or all ThinkPad?), it's 'YUY2_1280x720'
% For Emily(or all Mac?), it's 'YCbCr422_1280x720'
%
% TODO: Default is 640 * 480. Do we really want this?
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

%     back = double(getdata(obj,1))/ 255;
%     flushdata(obj);
%     set(h,'Cdata',back);
%     drawnow;
%     pause;    
    
    tic
    % Capturing and displaying the processed image during the run time of
    % the camera
    mask = genMask();
    have_back = 0;
    while islogging(obj)
        % Read a image from camera stream
        img = double(getdata(obj,1)) / 255;
        % The following line performs color space transformation
        % I = ycbcr2rgb(I);
        %% Game's on
        % TODO: I can't extract a background outside the loop. Back and img
        % will be the same
        if have_back == 0 
            back = img;
            have_back = 1;
        end
        if toc > critical_time
            body = cropBody(img, back);
            judge = isPass(body, mask);
            if toc > critical_time
                % A new level of game
                mask = genMask();
                showMsg(judge);
                tic
            else
                % We want the users to be greenish or redish should him success
                % or fail. 
                img = drawOutfit(judge, img, mask);
            end
        end
        %% Image processing part goes here
        % Remove all logged data records associated with object
        flushdata(obj);
        %% This is what paints on the canvas
        set(h, 'Cdata', img);
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