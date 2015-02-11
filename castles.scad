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

module drawRoundFirstTower(r, h) {
	union() {
		cylinder(r = r, h = h * 0.2, $fn = 30);

		difference() {
			cylinder(r = r * 0.8, h = h - r, $fn = 30);

			translate([0, 0, h * 0.195])
				for(i = [1 : 12]) {
					rotate(a = [0, 0, i * 30])
						translate([r * 0.7, 0, 0])
							cube([r * 0.2, r * 0.2, h * 0.81 - r]);
				}
		}

		difference() {
			translate([0, 0, h - r]) 
				cylinder(r1 = r, r2 = r * 0.9, h = r, $fn = 30);
	
			translate([0, 0, h - r * 0.5])
				cylinder(r = 0.6 * r, h = r * 0.51, $fn = 30);
		}
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