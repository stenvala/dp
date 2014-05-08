Z0 = 0; // Z-coordinate
CharacteristicLength = 0.0003; // mesh size control
SizeFactor = 1e-3; // some size factor


// Surroundings
Point(1) = {-1*SizeFactor, -1*SizeFactor, Z0, CharacteristicLength};
Point(2) = {-1*SizeFactor, 1*SizeFactor, Z0, CharacteristicLength};
Point(3) = {1*SizeFactor, 1*SizeFactor, Z0, CharacteristicLength};
Point(4) = {1*SizeFactor, -1*SizeFactor, Z0, CharacteristicLength};
// Area inside
Point(5) = {-0.5*SizeFactor, -0.5*SizeFactor, Z0, CharacteristicLength/2};
Point(6) = {-0.5*SizeFactor, 0.5*SizeFactor, Z0, CharacteristicLength/2};
Point(7) = {0.5*SizeFactor, 0.5*SizeFactor, Z0, CharacteristicLength/2};
Point(8) = {0.5*SizeFactor, -0.5*SizeFactor, Z0, CharacteristicLength/2};

// Lines for condensator box
Line(1) = {1, 2};
Line(2) = {2, 3};
Line(3) = {3, 4};
Line(4) = {4, 1};
// Lines for insulator area inside
Line(5) = {5, 6};
Line(6) = {6, 7};
Line(7) = {7, 8};
Line(8) = {8, 5};

// insulator
Line Loop(3002) = {5,6,7,8};
Plane Surface(3102) = {3002};

// condensator box
Line Loop(3001) = {1,2,3,4};
Ruled Surface(3101) = {3001,-3002};

// tags for domains
Physical Surface(2001) = {3101}; // air
Physical Surface(2002) = {3102}; // insulator

// boundary conditions
Physical Line(1001) = {2}; // potential high
Physical Line(1002) = {4}; // potential low
Physical Line(1003) = {1}; // flux line left
Physical Line(1004) = {3}; // flux line right
