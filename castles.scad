include <squareTowerWithTopCross.scad>
include <squareTowerWithCorners.scad>
include <squareTowerWithTriangle.scad>
include <roundFirstTower.scad>
include <squareTower.scad>

SPACE_BETWEEN_TOWERS = 20;
SPACE_BASE_POSITION = 0;

module drawSecondRoundBaseTower(radius, height) {
	heightFirstCylinder = height - radius * 0.8;
	radiusSecondCylinder = radius * 0.9;
	heightSecondCylinder = height - radius * 0.7;
	
	difference() {
		drawCylinder(radius, heightFirstCylinder);
		drawCylinder(radiusSecondCylinder, heightSecondCylinder);
	}
}

module drawCentralColumnRoundBaseTower(radius, height) {
	FirstCylinderRadius = radius * 0.65;
	FirstCylinderHeight = height - radius * 0.3;
	SecondCylinderRadius = radius * 0.4;

	drawCylinder(FirstCylinderRadius, FirstCylinderHeight);
	drawCylinder(SecondCylinderRadius, height);
}

module drawTopFloorSecondRoundTower(radius, height) {
	xPosition = height - radius * 0.25;
	position = [SPACE_BASE_POSITION, SPACE_BASE_POSITION, xPosition];
	cylinderHeight = radius * 0.075;
	
	translate(position)
		drawCylinder(radius, cylinderHeight);

}

module drawCubeDecoration(radius) {
	xCube = radius * 0.55;
	yCube = radius * 0.075;
	zCube = radius * 0.2;
	cudeDimensions = [xCube, yCube , zCube];

	cube(cudeDimensions);
}
module drawBlodDecoration(index, radius) {
	xPositon = radius * 0.45;
	position = [xPositon, SPACE_BASE_POSITION, SPACE_BASE_POSITION];

	translate(position)
		drawCubeDecoration(radius);
}

module drawDecorationSecondRoundTower(radius, height) {
	RANGE = [1 : 24];

	for (index = RANGE) {
		rotate([SPACE_BASE_POSITION, SPACE_BASE_POSITION, index * 15])
			drawBlodDecoration(index, radius);
	}
}

module drawTopDecorationSecondRoundTower(radius, height) {
	position = [SPACE_BASE_POSITION, SPACE_BASE_POSITION, height - radius * 0.25];
	
	translate(position) {
		drawDecorationSecondRoundTower(radius, height);
	}
}

module drawSecondRoundTower(radius, height) {
	union() {
		drawSecondRoundBaseTower(radius, height);
		drawCentralColumnRoundBaseTower(radius, height);
		drawTopFloorSecondRoundTower(radius, height);
		drawTopDecorationSecondRoundTower(radius, height);
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