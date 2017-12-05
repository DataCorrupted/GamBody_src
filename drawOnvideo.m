function drawOnvideo()
% Just realized maybe we need to put this whole loop in main.
% We will see later
% 
% This code will be moved to drawOutfit later.
% We want the users to be greenish or redish should him success or fail
% This requires stream changing. We may have a global flag for success or 
% fail and then tune the stream here.
%
% -- Peter Rong
%
% Do real-time webcam processing and displaying
%
% In this demo I just draw a yellow circle on the canvas

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

% TODO: We can't have each user to tune this code for themselves!
% Can we ask MATLAB to do all the checking and installing by itself?
% --Solved
imafo = imaqhwinfo;
adaptor = imafo(1).InstalledAdaptors{1};
adapinfo = imaqhwinfo(adaptor,1);
formats = adapinfo.DefaultFormat;
obj = videoinput(adaptor, 1, formats);
try
    % Initialize various parameters, and load in the template data
    set(obj,'framesperTrigger',10,'TriggerRepeat',Inf);
    start(obj);

    % h is a handle to the canvas
    h = imshow(zeros(720,1280));
    hold on;

    % Capturing and displaying the processed image during the run time of
    % the camera
    while islogging(obj)
        %% Image processing part goes here
        I = getdata(obj,1);
        I = ycbcr2rgb(I);
        % Remove all logged data records associated with object
        flushdata(obj);
        % Here just draw a circle, but other operations can be performed
        I = insertShape(I,'circle',[640 300 100],'Linewidth',5);
        
        % This makes the center of image greenish.
        % Given a correct mask we can achieve anything.
        I(180:540, 320:960, 2) = I(180:540, 320:960, 2) * 1.5;

        %% This is what paints on the canvas
        set(h,'Cdata',I);
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