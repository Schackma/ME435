clc;
clear;
close all;

imageData1 = imread('me435 slides logo.png','png');
imageData2 = imread('me435-robot.jpg','jpg');
imageData3 = imread('Motor pin out.png','png');

f1 = figure(1);
f2 = figure(2);
f3 = figure(3);
a1 = axes('Parent',f1);
a2 = axes('Parent',f2);
image(imageData1,'Parent',a1);
image(imageData2,'Parent',a2);

% Swap images
image(imageData2,'Parent',a1);
image(imageData1,'Parent',a2);

%Use any image
image(imageData3,'Parent',a2);

%Put the slide image back on a1
image(imageData1,'Parent',a1);

%Correcting aspect ration of logo
set(a2,'Units','Pixel','Position',[150 150 200 200]);
set(a2,'Position',a2.Position+[150 0 0 0 ]);
set(a2,'Visible','Off');

[rows_height,cols_width,depth] = size(imageData1);
axisWidth = 300;
axisHeight = axisWidth*rows_height/cols_width;

set(a1,'Units','Pixels','Position',[50,50,axisWidth,axisHeight],...
    'Visible','Off');

%messing around
set(a1,'Parent',f3);
set(a2,'Parent',f3);

