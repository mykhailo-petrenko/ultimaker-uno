$fn=40;

DIAMETER_IN = 61;
THICKNESS = 1.2;
SUPPORT_SIZE = 70;

M_DISTANCE = 72;
M_DIAMETER = 9;

RADIUS_IN = DIAMETER_IN / 2;
M_RADIUS = M_DIAMETER / 2;


//translate([0, 0, THICKNESS])
module shearedCylinder(shearingX=0, shearingY=0) {
    M = [[1, 0, shearingX, 0],
         [0, 1, shearingY, 0],
         [0, 0, 1, 0],
         [0, 0, 0, 1]];
    
    multmatrix(M) {
        difference() {
            cylinder(r=RADIUS_IN + THICKNESS, h=40, center=false);
            translate([0, 0, -1])
            cylinder(r=RADIUS_IN, h=28.5, center=false);
        }
    }
}

module main() {
    difference() {
        translate([0, 0, THICKNESS])
        shearedCylinder(1.8);
        translate([SUPPORT_SIZE/2, -SUPPORT_SIZE/2, 0])
        cube([SUPPORT_SIZE*2, SUPPORT_SIZE, 50], center=false);
        
        translate([-SUPPORT_SIZE/2, -SUPPORT_SIZE/2, 30])
        cube([SUPPORT_SIZE*2, SUPPORT_SIZE*2, SUPPORT_SIZE], center=false);
    }
}

module bolt_hole() {
    translate([0, 0, -1])
        cylinder(r=M_RADIUS, h=THICKNESS+2, center=false);
    
    
}

module bolt_holes() {
    m = M_DISTANCE / 2;
    shift = sqrt(m * m / 2);
    
    translate([shift, -shift, 0]) bolt_hole();
    translate([-shift, shift, 0]) bolt_hole();
}

module support() {
    difference() {
        translate([-SUPPORT_SIZE/2, -SUPPORT_SIZE/2, 0])
        cube([SUPPORT_SIZE, SUPPORT_SIZE, THICKNESS], center=false);
        translate([0, 0, -1])
        cylinder(r=RADIUS_IN, h=THICKNESS+2, center=false);
        bolt_holes();
    }
}

union() {
    main();
    support();
}