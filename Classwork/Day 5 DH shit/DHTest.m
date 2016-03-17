clc 

clear all


A1 = homogeneousTransformation(2,3,0,0)
A2 = homogeneousTransformation(3,0,0,0)

pointAonLink1 = [0;0;2;1];


pointBOnLink1 = [1;0;1;1];

pointBonBase =A1*A2*pointBOnLink1