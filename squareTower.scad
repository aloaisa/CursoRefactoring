module drawColumnTower(2dFillSpace) {
	position = [SPACE_BASE_POSITION, SPACE_BASE_POSITION, halfOf(2dFillSpace[Y])];
	dimensions = [2dFillSpace[X], 2dFillSpace[X], 2dFillSpace[Y]];

	drawCube(position, dimensions);
}
