CUBE_CENTER = true;

function halfOf(item) = item / 2;

module drawColumnTower(2dFillSpace) {
	position = [SPACE_BASE_POSITION, SPACE_BASE_POSITION, halfOf(2dFillSpace[Y])];
	dimensions = [2dFillSpace[X], 2dFillSpace[X], 2dFillSpace[Y]];

	drawCube(position, dimensions);
}

module drawCube(position, dimensions) {
	translate(position)
		cube(dimensions, center = CUBE_CENTER);
}
