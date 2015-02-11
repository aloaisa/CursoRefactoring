include <squareTowerWithTopCross.scad>
include <squareTowerWithCorners.scad>
include <squareTower.scad>

SPACE_BETWEEN_TOWERS = 20;
SPACE_BASE_POSITION = 0;

module drawTriangularRoofTower(width, height) {
	difference() {
		union() {
			difference() {
				union() {
					drawColumnTower([width, height]);
					drawTopFloorTriangularSpace([width, height]);
				}
				drawTopEmptyTriangularSpace([width, height]);
			}
			drawTopTriangle([width, height]);
		}
		drawWindows(width, height);
	}
}

module drawWindows(width, height) {
	halfWidth = halfOf(width);
	dimensionVariation = width * 0.2;
	zPosition = height - width * 0.8;

	positionWindow1 = [halfWidth, SPACE_BASE_POSITION, zPosition];
	positionWindow2 = [SPACE_BASE_POSITION, halfWidth, zPosition];
	positionWindow3 = [SPACE_BASE_POSITION, -halfWidth, zPosition];
	positionWindow4 = [-halfWidth, SPACE_BASE_POSITION, zPosition];
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

module tower_r0(r, h){
	union(){
	cylinder(r=r, h=h*0.2, $fn=30);
	difference(){
	cylinder(r=r*0.8, h=h-r, $fn=30);
	translate([0, 0, h*0.195])
	for(i=[1:12]){
		rotate(a=[0, 0, i*30])
		translate([r*0.7, 0, 0])
		cube([r*0.2, r*0.2, h*0.81-r]);
	}
	}
	difference(){
		translate([0, 0, h-r]) 
		cylinder(r1=r, r2=r*0.9, h=r, $fn=30);
		translate([0, 0, h-r*0.5])
		cylinder(r=0.6*r, h=r*0.51, $fn=30);
	}
	}
}

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

module drawSquareTowers() {
	WIDTH = 10;
	HEIGTH = 15;
	2dFillSpace = [WIDTH, HEIGTH];

	positionFirstTower = [-SPACE_BETWEEN_TOWERS, SPACE_BASE_POSITION, SPACE_BASE_POSITION];
	positionSecondTower = [SPACE_BASE_POSITION, SPACE_BASE_POSITION, SPACE_BASE_POSITION];
	positionThirdTower = [SPACE_BETWEEN_TOWERS, SPACE_BASE_POSITION, SPACE_BASE_POSITION];

	translate(positionFirstTower)
		drawSquareTowerWithTopCross(2dFillSpace);

	translate(positionSecondTower)
		drawSquareBasicTower(2dFillSpace);

	translate(positionThirdTower)
		drawTriangularRoofTower(WIDTH, HEIGTH);
}

module drawRoundTowers() {
	positionFirstTower = [SPACE_BASE_POSITION, SPACE_BETWEEN_TOWERS, SPACE_BASE_POSITION];
	positionSecondTower = [SPACE_BETWEEN_TOWERS, SPACE_BETWEEN_TOWERS, SPACE_BASE_POSITION];

	translate(positionFirstTower)
		tower_r0(5, 15);

	translate(positionSecondTower)
		tower_r1(8, 20);
}

module main() {
	drawSquareTowers();
	drawRoundTowers();
}

main();