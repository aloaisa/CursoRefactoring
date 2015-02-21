DEGRESS = 30;

module drawColumn(radius, height) {
	X_POSITION = radius * 0.7;
	X_CUBE = radius * 0.2;
	Y_CUBE = radius * 0.2;
	Z_CUBE = height * 0.81 - radius;

	position = [X_POSITION, SPACE_BASE_POSITION, SPACE_BASE_POSITION];
	3dCube = [X_CUBE, Y_CUBE, Z_CUBE];

	translate(position)
		cube(3dCube);

}

module drawCylinder(radius, height) {
	DEGRESS = 30;
	cylinder(r = radius, h = height, $fn = DEGRESS);
}

