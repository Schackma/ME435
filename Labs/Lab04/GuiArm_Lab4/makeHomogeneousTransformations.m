function [A1, A2, A3, A4, A5] = makeHomogeneousTransformations(degreesTheta1, degreesTheta2, degreesTheta3, degreesTheta4, degreesTheta5)
%MAKEHOMOGENEOUSTRANSFORMATIONS Create the DH matrices for the arm.

A1 = homogeneousTransformation(0.00, 0.00, 090, degreesTheta1);
A2 = homogeneousTransformation(3.15, 0.00, 000, degreesTheta2);
A3 = homogeneousTransformation(3.19, 0.00, 000, degreesTheta3);
A4 = homogeneousTransformation(0.00, 0.00, -90, degreesTheta4);
A5 = homogeneousTransformation(0.00, 7.75, 000, degreesTheta5);

end
