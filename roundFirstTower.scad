include <roundTower.scad>

module createRoundFirstTower() {
	RADIUS = 5;
	HEIGHT = 15;
	drawRoundFirstTower(RADIUS, HEIGHT);
}

module drawRoundFirstTowerTopFloor(radius, height) {
	DEGRESS = 30;
	positionTopFloor = [SPACE_BASE_POSITION, SPACE_BASE_POSITION, height - radius];
	radius2TopFloor = radius * 0.9;
	positionTopFloorSpace = [SPACE_BASE_POSITION, SPACE_BASE_POSITION, height - radius * 0.5];
	radiusTopFloorSpace = 0.6 * radius;
	heightTopFloor = radius * 0.51;

	difference() {
		drawTopFloorCylinder();
		translate(positionTopFloor) 
			cylinder(r1 = radius, r2 = radius2TopFloor, h = radius, $fn = DEGRESS);
	
		translate(positionTopFloorSpace)
			cylinder(r = radiusTopFloorSpace, h = heightTopFloor, $fn = DEGRESS);
	}
}

module drawRoundFirstTower(radius, height) {
	DEGRESS = 30;
	baseHeight = height * 0.2;

	union() {
		drawCylinder(radius, baseHeight);
		drawRoundFisrtTowerPrincipalColumn(radius, height);
		drawRoundFirstTowerTopFloor(radius, height);
	}
}

module drawRoundFisrtTowerPrincipalColumn(radius, height) {
	DEGRESS = 30;
	position = [SPACE_BASE_POSITION, SPACE_BASE_POSITION, height * 0.195];

	difference() {
		drawCylinder(radius * 0.8, height - radius);
		
		translate(position)
			for(i = [1 : 12]) {
				rotate(a = [SPACE_BASE_POSITION, SPACE_BASE_POSITION, i * DEGRESS])
					drawColumn(radius, height);
			}
	}
}
