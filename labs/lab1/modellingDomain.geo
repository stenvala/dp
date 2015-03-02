// DIMENSIONS
ALlength = 10e-3;
ALwidth = 7e-3;
CUlength = 10e-3;
CUwidth = 3e-3;

// MESHING PARAMETERS
Include "modellingDomainParameters.geo";
CharLength = 0.7*1e-3*CharScale;
CharLengthContact = 0.3*1e-3*CharScale;

// POINTS
Point(1) = {0, 0, 0, CharLength};
Point(2) = {0, ALwidth, 0, CharLength};
Point(3) = {ALlength+CUwidth, ALwidth, 0, CharLengthContact};
Point(4) = {ALlength+CUwidth, -CUlength, 0, CharLength};
Point(5) = {ALlength, -CUlength, 0, CharLength};
Point(6) = {ALlength, 0, 0, CharLengthContact};

// LINES (ORIENTATION FROM LOWER NUMBER TO HIGHER)
Line(1) = {1,2};
Line(2) = {2,3};
Line(3) = {3,4};
Line(4) = {4,5};
Line(5) = {5,6};
Line(6) = {1,6};

// INTERFACE LINE
Line(7) = {3,6};

// UPPER PART (Al)
Line Loop(20) = {1,2,7,-6};
Plane Surface(21) = {20};
// LOWER PART (Cu)
Line Loop(22) = {-7,3,4,5};
Plane Surface(23) = {22};

Physical Surface(2001) = {21}; // Cu
Physical Surface(2002) = {23}; // Al

Physical Line(1001) = {2,3,5,6}; // Electric insulation
Physical Line(1002) = {1}; // Potential1
Physical Line(1003) = {4}; // Potential2

