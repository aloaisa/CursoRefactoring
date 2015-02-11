module drawTriangularRoofTower(2dFillSpace) {
	difference() {
		union() {
			difference() {
				union() {
					drawColumnTower(2dFillSpace);
					drawTopFloorTriangularSpace(2dFillSpace);
				}
				drawTopEmptyTriangularSpace(2dFillSpace);
			}
			drawTopTriangle(2dFillSpace);
		}
		drawWindows(2dFillSpace);
	}
}

module drawWindows(2dFillSpace) {
	halfDimension = halfOf(2dFillSpace[X]);
	dimensionVariation = 2dFillSpace[X] * 0.2;
	zPosition = 2dFillSpace[Y] - 2dFillSpace[X] * 0.8;

	positionWindow1 = [halfDimension, SPACE_BASE_POSITION, zPosition];
	positionWindow2 = [SPACE_BASE_POSITION, halfDimension, zPosition];
	positionWindow3 = [SPACE_BASE_POSITION, -halfDimension, zPosition];
	positionWindow4 = [-halfDimension, SPACE_BASE_POSITION, zPosition];
	positionWindows = [positionWindow1, positionWindow2, positionWindow3, positionWindow4];

	windowDimensions = [dimensionVariation, dimensionVariation, dimensionVariation];

	indexWindows = [0 : len(positionWindows)];
	for(index = indexWindows) {
		drawWindow(positionWindows[index], windowDimensions);
	}
}

module drawWindow(position, dimensions) {
	translate(position)
		cube(dimensions, center = CUBE_CENTER);
}

module drawTopTriangle(2dFillSpace) {
	ROTATE_ANGLE = [90, 0, 0];
	zVariation = 2dFillSpace[Y] - 2dFillSpace[X] * 0.2;
	position = [SPACE_BASE_POSITION, SPACE_BASE_POSITION, zVariation];
	
	translate(position) rotate(a = ROTATE_ANGLE) 
			drawTriangle(2dFillSpace[X]);
}

module drawTriangle(width) {
	variationTriangle = halfOf(width);

	xTriangle = [-variationTriangle, SPACE_BASE_POSITION];
	yTriangle = [variationTriangle, SPACE_BASE_POSITION];
	zTriangle = [SPACE_BASE_POSITION, variationTriangle];

	3dTrianglePolygon = [xTriangle, yTriangle, zTriangle];

	linear_extrude(height = width, center = CUBE_CENTER)
		polygon(points=3dTrianglePolygon);

}

module drawTopEmptyTriangularSpace(2dFillSpace) {
	zVariationPosition = 2dFillSpace[Y] - 2dFillSpace[X] * 0.195;
	zVariationDimension = 2dFillSpace[X] * 0.4;

	position = [SPACE_BASE_POSITION, SPACE_BASE_POSITION, zVariationPosition];
	dimensions = [2dFillSpace[X], 2dFillSpace[X], zVariationDimension];

	translate(position) 
			cube(dimensions, center = CUBE_CENTER);
}

function calculateTriangleDimensions(2DSpace, 3DVariations) = [2DSpace[X] * 3DVariations[X],
															 2DSpace[X] * 3DVariations[X],
															 2DSpace[X] * 3DVariations[Z]];


module drawTopFloorTriangularSpace(2dFillSpace) {
	X_DIMENSION_VARIATION = 1.2;
	Y_DIMENSION_VARIATION = 1.2;
	Z_DIMENSION_VARIATION = 0.5;
	3dDimensionVariations = [X_DIMENSION_VARIATION, Y_DIMENSION_VARIATION, Z_DIMENSION_VARIATION];

	drawTriangleTopCubeWithVariations(2dFillSpace, 3dDimensionVariations);
}

module drawTriangleTopCubeWithVariations(2dFillSpace, 3dDimensionVariations) {
	Z_DIMENSION_VARIATION = 0.25;
	border_z_position = 2dFillSpace[Y] - 2dFillSpace[X] * Z_DIMENSION_VARIATION;
	position = [SPACE_BASE_POSITION, SPACE_BASE_POSITION, border_z_position];

	dimensions = calculateTriangleDimensions(2dFillSpace, 3dDimensionVariations);

	drawCube(position, dimensions);
}
