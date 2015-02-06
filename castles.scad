include <squareTowerWithTopCross.scad>
include <squareTower.scad>

SPACE_BETWEEN_TOWERS = 20;
SPACE_BASE_POSITION = 0;

// tower with triangular roof
module tower_s1(blen, height){
	difference(){
	union(){
	difference(){
		union(){
			translate([0, 0, height/2]) 
			cube([blen, blen, height], center=true);
			translate([0, 0, height-blen*0.25]) 
			cube([blen*1.2, blen*1.2, blen*0.5], center=true);
		}
		translate([0, 0, height-blen*0.195]) 
		cube([blen, blen, blen*0.4], center=true);
	}
	translate([0, 0, height-blen*0.2]) rotate(a=[90, 0, 0]) 
	linear_extrude(height = blen, center = true)
	polygon(points=[[-blen/2, 0], [blen/2, 0], [0, blen/2]]);
	}
	translate([blen/2, 0, height-blen*0.8])
	cube([blen*0.2, blen*0.2, blen*0.2], center=true);
	translate([0, blen/2, height-blen*0.8])
	cube([blen*0.2, blen*0.2, blen*0.2], center=true);
	translate([0, -blen/2, height-blen*0.8])
	cube([blen*0.2, blen*0.2, blen*0.2], center=true);
	translate([-blen/2, 0, height-blen*0.8])
	cube([blen*0.2, blen*0.2, blen*0.2], center=true);
	}
}

module drawSquareBasicTower(width, heigth) {
	difference() {
		drawColumnTower([width, heigth]);
		drawBasicTopFloorSpace([width, heigth]);
	}

	for(i = [1 : 4]) {
		rotate([0, 0, 90 * i])
			translate([width * 0.3, width * 0.3, heigth])
				cube([width * 0.2, width * 0.2, width * 0.1]);
	}
}

function calculateBasicDimensions(2DSpace, 3DVariations) = [2DSpace[X] * 3DVariations[X],
														 2DSpace[X] * 3DVariations[Y],
														 2DSpace[X] * 3DVariations[Z]];

module drawBasicTopFloorSpace(2dFillSpace) {
	X_DIMENSION_VARIATION = 0.8;
	Y_DIMENSION_VARIATION = 0.8;
	Z_DIMENSION_VARIATION = 0.4;

	3dDimensionVariations = [X_DIMENSION_VARIATION, Y_DIMENSION_VARIATION, Z_DIMENSION_VARIATION];

	drawBasicCubeWithVariations(2dFillSpace, 3dDimensionVariations);
}

module drawBasicCubeWithVariations(2dFillSpace, 3dVariations) {

	position = [SPACE_BASE_POSITION, SPACE_BASE_POSITION, 2dFillSpace[Y]];
	dimensions = calculateBasicDimensions(2dFillSpace, 3dVariations);

	drawCube(position, dimensions);
}

module tower_r0(r, h){
	union(){
	cylinder(r=r, h=h*0.2, $fn=30);
	difference(){
	cylinder(r=r*0.8, h=h-r, $fn=30);
	translate([0, 0, h*0.195])
	for(i=[1:12]){
		rotate(a=[0, 0, i*30])
		translate([r*0.7, 0, 0])
		cube([r*0.2, r*0.2, h*0.81-r]);
	}
	}
	difference(){
		translate([0, 0, h-r]) 
		cylinder(r1=r, r2=r*0.9, h=r, $fn=30);
		translate([0, 0, h-r*0.5])
		cylinder(r=0.6*r, h=r*0.51, $fn=30);
	}
	}
}

module tower_r1(r, h){
	union(){
	difference(){
	cylinder(r=r, h=h-r*0.8, $fn=30);
	cylinder(r=r*0.9, h=h-r*0.7, $fn=30);
	}
	cylinder(r=r*0.65, h=h-r*0.3, $fn=30);
	cylinder(r=r*0.4, h=h, $fn=30);
	translate([0, 0, h-r*0.25])
	cylinder(r=r, h=r*0.075, $fn=30);
	translate([0, 0, h-r*0.25]){
	for(i=[1:24]){
		rotate([0, 0, i*15])
		translate([r*0.45, 0, 0])
		cube([r*0.55, r*0.075, r*0.2]);
	}
	}
	}
}

module drawSquareTowers() {
	WIDTH = 10;
	HEIGTH = 15;

	positionFirstTower = [-SPACE_BETWEEN_TOWERS, SPACE_BASE_POSITION, SPACE_BASE_POSITION];
	positionSecondTower = [SPACE_BASE_POSITION, SPACE_BASE_POSITION, SPACE_BASE_POSITION];
	positionThirdTower = [SPACE_BETWEEN_TOWERS, SPACE_BASE_POSITION, SPACE_BASE_POSITION];

	translate(positionFirstTower)
		drawSquareTowerWithTopCross([WIDTH, HEIGTH]);

	translate(positionSecondTower)
		drawSquareBasicTower(WIDTH, HEIGTH);

	translate(positionThirdTower)
		tower_s1(WIDTH, HEIGTH);
}

module drawRoundTowers() {
	positionFirstTower = [SPACE_BASE_POSITION, SPACE_BETWEEN_TOWERS, SPACE_BASE_POSITION];
	positionSecondTower = [SPACE_BETWEEN_TOWERS, SPACE_BETWEEN_TOWERS, SPACE_BASE_POSITION];

	translate(positionFirstTower)
		tower_r0(5, 15);

	translate(positionSecondTower)
		tower_r1(8, 20);
}

module main() {
	drawSquareTowers();
	drawRoundTowers();
}

main();