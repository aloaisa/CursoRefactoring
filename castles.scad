include <squareTowerWithTopCross.scad>
include <squareTowerWithCorners.scad>
include <squareTowerWithTriangle.scad>
include <squareTower.scad>

SPACE_BETWEEN_TOWERS = 20;
SPACE_BASE_POSITION = 0;

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

module drawCylinder(radius, height) {
	DEGRESS = 30;
	cylinder(r = radius, h = height, $fn = DEGRESS);
}

module drawRoundFirstTowerTopFloor(radius, height) {
	DEGRESS = 30;

	difference() {
			translate([SPACE_BASE_POSITION, SPACE_BASE_POSITION, height - radius]) 
				cylinder(r1 = radius, r2 = radius * 0.9, h = radius, $fn = DEGRESS);
	
			translate([SPACE_BASE_POSITION, SPACE_BASE_POSITION, height - radius * 0.5])
				cylinder(r = 0.6 * radius, h = radius * 0.51, $fn = DEGRESS);
		}
}

module drawRoundFisrtTowerPrincipalColumn(radius, height) {
	difference() {
		drawCylinder(radius * 0.8, height - radius);

		translate([SPACE_BASE_POSITION, SPACE_BASE_POSITION, height * 0.195])
			for(i = [1 : 12]) {
				rotate(a = [SPACE_BASE_POSITION, SPACE_BASE_POSITION, i * DEGRESS])
					translate([radius * 0.7, SPACE_BASE_POSITION, SPACE_BASE_POSITION])
						cube([radius * 0.2, radius * 0.2, height * 0.81 - radius]);
			}
	}
}

module drawRoundFirstTower(radius, height) {
	DEGRESS = 30;

	union() {
		drawCylinder(radius, height * 0.2);
		drawRoundFisrtTowerPrincipalColumn(radius, height);
		drawRoundFirstTowerTopFloor(radius, height);
	}
}

module createRoundFirstTower() {
	RADIUS = 5;
	HEIGHT = 15;
	positionFirstTower = [SPACE_BASE_POSITION, SPACE_BETWEEN_TOWERS, SPACE_BASE_POSITION];

	translate(positionFirstTower)
		drawRoundFirstTower(RADIUS, HEIGHT);
}

module createRoundSecondTower() {
	RADIUS = 8;
	HEIGHT = 20;

	positionSecondTower = [SPACE_BETWEEN_TOWERS, SPACE_BETWEEN_TOWERS, SPACE_BASE_POSITION];

	translate(positionSecondTower)
		tower_r1(RADIUS, HEIGHT);
}

module drawSquareTowers() {
	WIDTH = 10;
	HEIGHT = 15;
	2dFillSpace = [WIDTH, HEIGHT];

	positionFirstTower = [-SPACE_BETWEEN_TOWERS, SPACE_BASE_POSITION, SPACE_BASE_POSITION];
	positionSecondTower = [SPACE_BASE_POSITION, SPACE_BASE_POSITION, SPACE_BASE_POSITION];
	positionThirdTower = [SPACE_BETWEEN_TOWERS, SPACE_BASE_POSITION, SPACE_BASE_POSITION];

	translate(positionFirstTower)
		drawSquareTowerWithTopCross(2dFillSpace);

	translate(positionSecondTower)
		drawSquareBasicTower(2dFillSpace);

	translate(positionThirdTower)
		drawTriangularRoofTower(2dFillSpace);
}

module drawRoundTowers() {
	createRoundFirstTower();
	createRoundSecondTower();
}

module main() {
	drawSquareTowers();
	drawRoundTowers();
}

main();