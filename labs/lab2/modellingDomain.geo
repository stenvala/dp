// Magneetin geometria

// Verkon m‰‰ritykset
dns1 = 0.003*3; // K‰‰mi
dns2 = 0.003*3; // Rauta
dns3 = 0.1; // Kaukana

L = 1; // koko leveys
H = 1; // koko korkeus

IlmaVali = 2e-2;
DyLovi = 2e-3;
DxLovi = 10e-3;
FeLev1 = 5.7e-2;
FeKor1 = 4.7e-2;
KaamiAukko = 8.9e-2;
FeLev2 = 6e-2;
FeKor2 = 3.2e-2;
FeLov1 = 0.952e-2;
FeKor3 = 9.4e-2;
FeKor4 = 13e-2;
FeLev4 = 16.8e-2;
KaamiD1 = 1.2e-2;
KaamiD2 = 0.157e-2;
KaamiD3 = 0.317e-2;

// Origo
Point(1) = {0,0,0,dns2};

// Rautasyd‰n
Point(2) = {0,IlmaVali,0,dns2};
Point(3) = {FeLev1-DxLovi,IlmaVali,0,dns2};
Point(4) = {FeLev1-DxLovi,IlmaVali-DyLovi,0,dns2};
Point(5) = {FeLev1,IlmaVali-DyLovi,0,dns2};
Point(6) = {FeLev1,IlmaVali+FeKor1,0,dns2};
Point(7) = {FeLev1+KaamiAukko,IlmaVali+FeKor1,0,dns2};
Point(8) = {FeLev1+KaamiAukko,0,0,dns2};
Point(9) = {FeLev1+KaamiAukko+FeLev2,0,0,dns2};
Point(10) = {FeLev1+KaamiAukko+FeLev2,FeKor2,0,dns2};
Point(11) = {FeLev1+KaamiAukko+FeLev2-FeLov1,FeKor2,0,dns2};
Point(12) = {FeLev1+KaamiAukko+FeLev2-FeLov1,FeKor3,0,dns2};
Point(13) = {FeLev4,FeKor4,0,dns2};
Point(14) = {0,FeKor4,0,dns2};

// K‰‰mi
Point(21) = {FeLev1+KaamiD1,IlmaVali-DyLovi+KaamiD3,0,dns1};
Point(22) = {FeLev1+KaamiD1,IlmaVali+FeKor1-KaamiD2,0,dns1};
Point(23) = {FeLev1+KaamiAukko-KaamiD2,IlmaVali+FeKor1-KaamiD2,0,dns1};
Point(24) = {FeLev1+KaamiAukko-KaamiD2,IlmaVali-DyLovi+KaamiD3,0,dns1};

// ƒ‰retˆn
Point(31) = {0,H,0,dns3};
Point(32) = {L,H,0,dns3};
Point(33) = {L,0,0,dns3};

// Viivat
Line(1) = {1,2};
Line(2) = {2,3};
Line(3) = {3,4};
Line(4) = {4,5};
Line(5) = {5,6};
Line(6) = {6,7};
Line(7) = {7,8};
Line(8) = {8,9};
Line(9) = {9,10};
Line(10) = {10,11};
Line(11) = {11,12};
Line(12) = {12,13};
Line(13) = {13,14};
Line(14) = {2,14};

Line(15) = {1,8};

Line(21) = {21,22};
Line(22) = {22,23};
Line(23) = {23,24};
Line(24) = {21,24};

Line(31) = {14,31};
Line(32) = {31,32};
Line(33) = {32,33};
Line(34) = {9,33};

// K‰‰mi
Line Loop(30) = {21,22,23,-24};
Plane Surface(31) = {30};
// Rauta
Line Loop(32) = {14,-13,-12,-11,-10,-9,-8,-7,-6,-5,-4,-3,-2};
Plane Surface(33) = {32};
// Sis‰ilma
Line Loop(33) = {1,2,3,4,5,6,7,-15};
Plane Surface(34) = {33,30};
// Ulkoilma
Line Loop(35) = {31,32,33,-34,9,10,11,12,13};
Plane Surface(36) = {35};

Physical Surface(2001) = {31}; // K‰‰mi
Physical Surface(2002) = {33}; // Rauta
Physical Surface(2003) = {34,36}; // Ilma

Physical Line(1001) = {15,8,34}; // y=0
Physical Line(1002) = {1,14,31}; // x=0 homog
Physical Line(1003) = {32}; // y=inf
Physical Line(1004) = {33}; // x=inf
