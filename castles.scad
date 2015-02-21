include <squareTowerWithTopCross.scad>
include <squareTowerWithCorners.scad>
include <squareTowerWithTriangle.scad>
include <roundFirstTower.scad>
include <roundSecondTower.scad>
include <squareTower.scad>

SPACE_BETWEEN_TOWERS = 20;
SPACE_BASE_POSITION = 0;

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