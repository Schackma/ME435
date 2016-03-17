function [ imageObject ] = addImageToAxes( imageFileName, axesHandle, axesWidth )
%ADDIMAGETOAXES Adds an image to an axes
%   Opens the image filename and adds it to the axes
%   Return the image object
%   If axesWidth = 0 then use the images default pixel size

% Open the fileto get the image data
img = imread(imageFileName);
% Create an image object and make the parent the axes
imageObject = image(img, 'Parent', axesHandle);

% Make units of the axes 'pixels'
% Visible off
set(axesHandle,'Units','Pixels','Visible','Off');

curPos = get(axesHandle,'Position');
% Get the current 'Position' of the Axes so that we can use the x and y
% Get the number of rows and columns of the image
[r, c, d] = size(img);
if axesWidth == 0
    axesWidth = c;
    axesHeight = r;
else
    axesHeight = axesWidth * (r/c);
end

% set the new 'Position' on the axes
set(axesHandle,'Position',[curPos(1),curPos(2),axesWidth,axesHeight]);

end
