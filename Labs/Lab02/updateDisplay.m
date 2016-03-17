function [imageObject] = updateDisplay( axesHandle, plateLocations, extended, xPos, gCon)
%% creating bad hard coding
h = 228; w = 426.4;
gripperScale = 1/5; gripperDisp = 45;
barScale = 0.85;    barDisp = 25;
boxPositions = [67,37;141,37;210,37;287,37;360,37];
plateScale = 1/4; plateVertDisp = 110; plateHorzDisp = 36;

%% loading in images
background = imread('robot_background.jpg');
background = imresize(background,[h,w]);
switch gCon
    case 1
        gripper = imread('gripper_closed_no_plate.jpg');
    case 2
        gripper = imread('gripper_open_no_plate.jpg');
    case 3
        gripper = imread('gripper_with_plate.jpg');
end
gripper = imresize(gripper,[h*gripperScale,w*gripperScale]);
bars = imread('extended_bars.jpg'); bars = imresize(bars,[barScale*size(bars,1),size(bars,2)]);
plate = imread('plate_only.jpg');   plate = imresize(plate,[plateScale*size(plate,1),plateScale*size(plate,2)]);

%% layering images
    startR = boxPositions(xPos,2);
    startC = boxPositions(xPos,1);
if(extended)
    background = overlay(background,bars,startR,startC-barDisp);
    startR = size(bars,1);
end
background = overlay(background,gripper,startR,startC-gripperDisp);

for i = 1:5
    if(plateLocations(i))
        startR = boxPositions(i,2)+plateVertDisp;
        startC = boxPositions(i,1)-plateHorzDisp;
        background = overlay(background,plate,startR,startC);
    end
end

imageObject = image(background, 'Parent', axesHandle);
end

function [img] = overlay(img,toPut,rowshift,colshift)
    img((1:size(toPut,1))+rowshift, (1:size(toPut,2))+colshift, :) = toPut;
end

