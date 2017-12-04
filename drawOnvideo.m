function drawOnvideo()
% drawOnVideo Summary of this function goes here
% 
% Do real-time webcam processing and displaying
%
% In this demo I just draw a yellow circle on the canvas

% the image acquisition hardware is reset
imaqreset
% The parameters may differ on distinct OS and PS, such as 'winvideo'
obj = videoinput('macvideo',1,'YCbCr422_1280x720');
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