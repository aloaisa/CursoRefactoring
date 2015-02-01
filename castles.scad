SPACE_BETWEEN_TOWERS = 20;
SPACE_BASE_POSITION = 0;
CUBE_CENTER = true;
X = 0;
Y = 1;
Z = 2;

function halfOf(item) = item / 2;

module drawSquareTower0(2dFillSpace) {
	difference() {
		drawColumnTower(2dFillSpace);
		drawTopFloorSpace(2dFillSpace);
		drawTopXCut(2dFillSpace);
		drawTopYCut(2dFillSpace);
	}
}

module drawColumnTower(2dFillSpace) {
	position = [SPACE_BASE_POSITION, SPACE_BASE_POSITION, halfOf(2dFillSpace[Y])];
	dimensions = [2dFillSpace[X], 2dFillSpace[X], 2dFillSpace[Y]];

	drawCube(position, dimensions);
}

module drawTopFloorSpace(2dFillSpace) {
	x_dimension_variation = 0.8;
	y_dimension_variation = 0.8;
	z_dimension_variation = 0.1;

	3d_dimension_variations = [x_dimension_variation, y_dimension_variation, z_dimension_variation];
	
	drawCubeWithVariations(2dFillSpace, 3d_dimension_variations);
}

module drawTopXCut(2dFillSpace) {
	x_dimension_variation = 1.1;
	y_dimension_variation = 0.15;
	z_dimension_variation = 0.2;

	3d_dimension_variations = [x_dimension_variation, y_dimension_variation, z_dimension_variation];
	
	drawCubeWithVariations(2dFillSpace, 3d_dimension_variations);
}

module drawTopYCut(2dFillSpace) {
	x_dimension_variation = 0.15;
	y_dimension_variation = 1.1;
	z_dimension_variation = 0.2;

	3d_dimension_variations = [x_dimension_variation, y_dimension_variation, z_dimension_variation];
	
	drawCubeWithVariations(2dFillSpace, 3d_dimension_variations);
}

module drawCubeWithVariations(2dFillSpace, 3dDimensionVariations) {
	xDimension = 2dFillSpace[X] * 3dDimensionVariations[X];
	yDimension = 2dFillSpace[X] * 3dDimensionVariations[Y];
	zDimension = 2dFillSpace[Y] * 3dDimensionVariations[Z];
	dimensions = [xDimension, yDimension, zDimension];

	position = [SPACE_BASE_POSITION, SPACE_BASE_POSITION, 2dFillSpace[Y]];

	drawCube(position, dimensions);
}

module drawCube(position, dimensions) {
	translate(position)
		cube(dimensions, center = CUBE_CENTER);
}


// tower with triangular roof
module tower_s1(blen, height){
	difference(){
	union(){
	difference(){
		union(){
			translate([0, 0, height/2]) 
			cube([blen, blen, height], center=true);
			translate([0, 0, height-blen*0.25]) 
			cube([blen*1.2, blen*1.2, blen*0.5], center=true);
		}
		translate([0, 0, height-blen*0.195]) 
		cube([blen, blen, blen*0.4], center=true);
	}
	translate([0, 0, height-blen*0.2]) rotate(a=[90, 0, 0]) 
	linear_extrude(height = blen, center = true)
	polygon(points=[[-blen/2, 0], [blen/2, 0], [0, blen/2]]);
	}
	translate([blen/2, 0, height-blen*0.8])
	cube([blen*0.2, blen*0.2, blen*0.2], center=true);
	translate([0, blen/2, height-blen*0.8])
	cube([blen*0.2, blen*0.2, blen*0.2], center=true);
	translate([0, -blen/2, height-blen*0.8])
	cube([blen*0.2, blen*0.2, blen*0.2], center=true);
	translate([-blen/2, 0, height-blen*0.8])
	cube([blen*0.2, blen*0.2, blen*0.2], center=true);
	}
}

// basic squarish tower
module tower_s2(len, h){
	difference(){
	translate([0, 0, h/2])
	cube([len, len, h], center=true);
	translate([0, 0, h])
	cube([len*0.8, len*0.8, len*0.4], center=true);
	}
	for(i=[1:4]){
		rotate([0, 0, 90*i])
		translate([len*0.3, len*0.3, h])
		cube([len*0.2, len*0.2, len*0.1]);
	}
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
	TOWER_SQUARE_WIDTH = 10;
	TOWER_SQUARE_HEIGHT = 15;

	POSITION_FIRST_TOWER = [-SPACE_BETWEEN_TOWERS, SPACE_BASE_POSITION, SPACE_BASE_POSITION];
	POSITION_SECOND_TOWER = [SPACE_BASE_POSITION, SPACE_BASE_POSITION, SPACE_BASE_POSITION];
	POSITION_THIRD_TOWER = [SPACE_BETWEEN_TOWERS, SPACE_BASE_POSITION, SPACE_BASE_POSITION];

	translate(POSITION_FIRST_TOWER)
		drawSquareTower0([TOWER_SQUARE_WIDTH, TOWER_SQUARE_HEIGHT]);

	translate(POSITION_SECOND_TOWER)
		tower_s2(TOWER_SQUARE_WIDTH, TOWER_SQUARE_HEIGHT);

	translate(POSITION_THIRD_TOWER)
		tower_s1(TOWER_SQUARE_WIDTH, TOWER_SQUARE_HEIGHT);
}

module drawRoundTowers() {
	POSITION_FIRST_TOWER = [SPACE_BASE_POSITION, SPACE_BETWEEN_TOWERS, SPACE_BASE_POSITION];
	POSITION_SECOND_TOWER = [SPACE_BETWEEN_TOWERS, SPACE_BETWEEN_TOWERS, SPACE_BASE_POSITION];

	translate(POSITION_FIRST_TOWER)
		tower_r0(5, 15);

	translate(POSITION_SECOND_TOWER)
		tower_r1(8, 20);
}

module main() {
	drawSquareTowers();
	drawRoundTowers();
}

main();