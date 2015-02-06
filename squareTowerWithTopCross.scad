function calculateDimensions(2DSpace, 3DVariations) = [2DSpace[X] * 3DVariations[X],
													   2DSpace[X] * 3DVariations[Y],
													   2DSpace[Y] * 3DVariations[Z]];


module drawSquareTowerWithTopCross(2dFillSpace) {
	difference() {
		drawColumnTower(2dFillSpace);
		drawTopFloorSpace(2dFillSpace);
		drawTopXCut(2dFillSpace);
		drawTopYCut(2dFillSpace);
	}
}

module drawTopFloorSpace(2dFillSpace) {
	X_DIMENSION_VARIATION = 0.8;
	Y_DIMENSION_VARIATION = 0.8;
	Z_DIMENSION_VARIATION = 0.1;

	3d_dimension_variations = [X_DIMENSION_VARIATION, Y_DIMENSION_VARIATION, Z_DIMENSION_VARIATION];

	drawCubeWithVariations(2dFillSpace, 3d_dimension_variations);
}

module drawTopXCut(2dFillSpace) {
	X_DIMENSION_VARIATION = 1.1;
	Y_DIMENSION_VARIATION = 0.15;
	Z_DIMENSION_VARIATION = 0.2;

	3d_dimension_variations = [X_DIMENSION_VARIATION, Y_DIMENSION_VARIATION, Z_DIMENSION_VARIATION];
	
	drawCubeWithVariations(2dFillSpace, 3d_dimension_variations);
}

module drawTopYCut(2dFillSpace) {
	X_DIMENSION_VARIATION = 0.15;
	Y_DIMENSION_VARIATION = 1.1;
	Z_DIMENSION_VARIATION = 0.2;

	3d_dimension_variations = [X_DIMENSION_VARIATION, Y_DIMENSION_VARIATION, Z_DIMENSION_VARIATION];

	drawCubeWithVariations(2dFillSpace, 3d_dimension_variations);
}

module drawCubeWithVariations(2dFillSpace, 3dDimensionVariations) {
	dimensions = calculateDimensions(2dFillSpace, 3dDimensionVariations);
	position = [SPACE_BASE_POSITION, SPACE_BASE_POSITION, 2dFillSpace[Y]];

	drawCube(position, dimensions);
}
