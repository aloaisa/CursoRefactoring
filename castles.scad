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

				translate([SPACE_BASE_POSITION, SPACE_BASE_POSITION, height - width * 0.195]) 
					cube([width, width, width * 0.4], center = true);
			}

			translate([SPACE_BASE_POSITION, SPACE_BASE_POSITION, height - width * 0.2]) rotate(a = [90, 0, 0]) 
				linear_extrude(height = width, center = true)
					polygon(points=[[-width / 2, 0], [width / 2, 0], [0, width / 2]]);
		}

		translate([width / 2, 0, height - width * 0.8])
			cube([width * 0.2, width * 0.2, width * 0.2], center = CUBE_CENTER);

		translate([0, width / 2, height - width * 0.8])
			cube([width * 0.2, width * 0.2, width * 0.2], center = CUBE_CENTER);

		translate([0, -width / 2, height - width * 0.8])
			cube([width * 0.2, width * 0.2, width * 0.2], center = CUBE_CENTER);

		translate([-width / 2, 0, height - width * 0.8])
			cube([width * 0.2, width * 0.2, width * 0.2], center = CUBE_CENTER);
	}
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
	border_z_position = 2dFillSpace[Y] - 2dFillSpace[X] * 0.25;
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