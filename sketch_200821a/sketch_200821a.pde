HoppeBold hoppeBold;

void setup() {
	size(900, 900);
	hoppeBold = new HoppeBold(50, 10);
}

void draw() {
	background(255);
	hoppeBold.update();
	hoppeBold.checkEdges();
	hoppeBold.display();
}
