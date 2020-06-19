/* Pursuit Curve
   Julian Syaputra
   Based on a paper by Michael Lloyd, Ph.D.
   https://www.hsu.edu/uploads/pages/2006-7afpursuit.pdf
*/

// On the following code i'm trying to simulate The Mice Problem
float dt = 0.01;
PGraphics path;
Pursue corner1, corner2, corner3, corner4;
//int n = 4; the number of vertices
//Pursue vertices[n];

void setup() {
  size(600, 600);
  // creating an object for each corners
  corner1 = new Pursue(new PVector(0, 0), 2, true);
  corner2 = new Pursue(new PVector(0, height), 2, true);
  corner3 = new Pursue(new PVector(width, height), 2, true);
  corner4 = new Pursue(new PVector(width, 0), 2, true);
  
  // use this to automate the declaration of the vertices
  //for(int i = 0; i < n; i++) {
  //  vertices[n] = new Pursure(Position Vector, vel. magnitude, isFox)   
  //}

  // creating a PGraphics object where all the drawings of the path are placed
  path = createGraphics(width, height);
  path.beginDraw();
  path.background(255);
  path.endDraw();
}

void draw() {
  // setups
  image(path, 0, 0);
  
  // displaying & updating each vertices position
  // the display function isn't really needed in this case
  corner1.display();
  corner2.display();
  corner3.display();
  corner4.display();
  corner1.update(corner2);
  corner2.update(corner3);
  corner3.update(corner4);
  corner4.update(corner1);

  // draws a line between each pursuer & pursuees for every certain moment
  // use this if you don't want the result to be less dense
  if (dt >= 0.05) {
    path.beginDraw();
    path.stroke(0);
    path.line(corner1.pos.x, corner1.pos.y, corner2.pos.x, corner2.pos.y);
    path.line(corner2.pos.x, corner2.pos.y, corner3.pos.x, corner3.pos.y);
    path.line(corner3.pos.x, corner3.pos.y, corner4.pos.x, corner4.pos.y);
    path.line(corner4.pos.x, corner4.pos.y, corner1.pos.x, corner1.pos.y);
    path.endDraw();
    dt = 0.01; // resetting the "time" counter
  }

  //draws each particle's path
  //path.beginDraw();
  //path.stroke(0);
  //path.line(corner1.pos.x, corner1.pos.y, corner2.pos.x, corner2.pos.y);
  //path.line(corner2.pos.x, corner2.pos.y, corner3.pos.x, corner3.pos.y);
  //path.line(corner3.pos.x, corner3.pos.y, corner4.pos.x, corner4.pos.y);
  //path.line(corner4.pos.x, corner4.pos.y, corner1.pos.x, corner1.pos.y);
  //path.endDraw();

  dt += 0.01;
}
