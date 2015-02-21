include <squareTowerWithTopCross.scad>
include <squareTowerWithCorners.scad>
include <squareTowerWithTriangle.scad>
include <roundFirstTower.scad>
include <squareTower.scad>

SPACE_BETWEEN_TOWERS = 20;
SPACE_BASE_POSITION = 0;

module drawSecondRoundTower(radius, height) {
	union() {
	
		difference() {
			cylinder(r = radius, h = height - radius * 0.8, $fn = DEGRESS);
			cylinder(r = radius * 0.9, h = height - radius * 0.7, $fn = DEGRESS);
		}

		cylinder(r = radius * 0.65, h = height - radius * 0.3, $fn = DEGRESS);
		cylinder(r = radius * 0.4, h = height, $fn = DEGRESS);

		translate([0, 0, height - radius * 0.25])
			cylinder(r = radius, h = radius * 0.075, $fn = DEGRESS);
		
		translate([0, 0, height - radius * 0.25]) {
			
			for(i = [1 : 24]) {
				rotate([0, 0, i * 15])
					translate([radius * 0.45, 0, 0])
						cube([radius * 0.55, radius * 0.075, radius * 0.2]);
			}
		}
	}
}

module createRoundSecondTower() {
	RADIUS = 8;
	HEIGHT = 20;
	drawSecondRoundTower(RADIUS, HEIGHT);
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
	positionFirstTower = [SPACE_BASE_POSITION, SPACE_BETWEEN_TOWERS, SPACE_BASE_POSITION];
	positionSecondTower = [SPACE_BETWEEN_TOWERS, SPACE_BETWEEN_TOWERS, SPACE_BASE_POSITION];

	translate(positionFirstTower)
		createRoundFirstTower();

	translate(positionSecondTower)
		createRoundSecondTower();
}

module main() {
	drawSquareTowers();
	drawRoundTowers();
}

main();