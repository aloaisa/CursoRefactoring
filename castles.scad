SPACE_BETWEEN_TOWERS = 20;
SPACE_BASE_POSITION = 0;
CUBE_CENTER = true;

function halfOf(item) = item / 2;

module drawSquareTower0(width, height) {
	difference() {
		drawColumnTower(width, height);
		drawTopFloorSpace(width, height);
		drawTopXCut(width, height);
		drawTopYCut(width, height);
	}
}

module drawColumnTower(width, height) {
	POSITION = [SPACE_BASE_POSITION, SPACE_BASE_POSITION, halfOf(height)];
	DIMENSIONS = [width, width, height];

	drawCube(POSITION, DIMENSIONS);
}

module drawTopFloorSpace(width, height) {
	POSITION = [SPACE_BASE_POSITION, SPACE_BASE_POSITION, height];

	DIMENSION_X = width * 0.8;
	DIMENSION_Y = width * 0.8;
	DIMENSION_Z = height * 0.1;
	DIMENSIONS = [DIMENSION_X, DIMENSION_Y, DIMENSION_Z];

	drawCube(POSITION, DIMENSIONS);
}

module drawTopXCut(width, height) {
	POSITION = [SPACE_BASE_POSITION, SPACE_BASE_POSITION, height];

	DIMENSION_X = width * 1.1;
	DIMENSION_Y = width * 0.15;
	DIMENSION_Z = height * 0.2;
	DIMENSIONS = [DIMENSION_X, DIMENSION_Y, DIMENSION_Z];

	drawCube(POSITION, DIMENSIONS);
}

module drawTopYCut(width, height) {
	POSITION = [SPACE_BASE_POSITION, SPACE_BASE_POSITION, height];

	DIMENSION_X = width * 0.15;
	DIMENSION_Y = width * 1.1;
	DIMENSION_Z = height * 0.2;
	DIMENSIONS = [DIMENSION_X, DIMENSION_Y, DIMENSION_Z];

	drawCube(POSITION, DIMENSIONS);
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
		drawSquareTower0(TOWER_SQUARE_WIDTH, TOWER_SQUARE_HEIGHT);

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