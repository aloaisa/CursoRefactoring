function calculateBasicDimensions(2DSpace, 3DVariations) = [2DSpace[X] * 3DVariations[X],
															2DSpace[X] * 3DVariations[Y],
															2DSpace[X] * 3DVariations[Z]];

module drawSquareBasicTower(2dFillSpace) {
	difference() {
		drawColumnTower(2dFillSpace);
		drawBasicTopFloorSpace(2dFillSpace);
	}

	drawTopCorners(2dFillSpace);
}

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

module drawTopCorners(2dFillSpace) {
	SQUARE_CORNERS_INDEX = [1 : 4];
	DIMENSION_VARIATION = 0.3;
	X_ROTATION = 0;
	Y_ROTATION = 0;
	Z_ROTATION = 90;
	position = [2dFillSpace[X] * DIMENSION_VARIATION, 2dFillSpace[X] * DIMENSION_VARIATION, 2dFillSpace[Y]];

	for(index = SQUARE_CORNERS_INDEX) {
		rotate([X_ROTATION, Y_ROTATION, Z_ROTATION * index])
			translate(position)
				drawCorner(2dFillSpace[X]);
	}
}

module drawCorner(size) {
	X_VARIATION_SIZE = 0.2;
	Y_VARIATION_SIZE = 0.2;
	Z_VARIATION_SIZE = 0.1;

	dimensions = [size * X_VARIATION_SIZE, size * Y_VARIATION_SIZE, size * Z_VARIATION_SIZE];

	cube(dimensions);
}
