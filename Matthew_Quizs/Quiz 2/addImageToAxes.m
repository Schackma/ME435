function [imageObject] =  addImageToAxes(imageFileName, axesHandle, axesWidth)

imageData = imread(imageFileName);

imageObject = image(imageData,'Parent',axesHandle);

set(axesHandle, 'Units','Pixels','Visible','Off');

currentPosition = get(axesHandle,'Position');

[rows_height, cols_width, depth] = size(imageData);

if axesWidth ==0
    axesWidth = cols_width;
    axesHeight = rows_height;
else
    axesHeight = axesWidth *rows_height/cols_width;
end
set(axesHandle, 'Position',[currentPosition(1),currentPosition(2), axesWidth, axesHeight]);

end