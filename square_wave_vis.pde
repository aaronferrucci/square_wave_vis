float[] X1 = new float[400];
float[] Y1 = new float[400];
float[] X2 = new float[400];
float[] Y2 = new float[400];
float angle = 0;
int diam = 150;
int radius = diam/2;
int ind = 0;

void setup(){
  size(450, 800, OPENGL);
  
}

void draw() {
  background(#FFFFFF);

  /*Draw ellipses here. Since the ellipses are filled with white,
  the largest ellipse has to be drawn first.*/
  ellipseMode(CENTER);
  /* Used Mathematica to find the max value of 75*cos(x)+115*cos(x+1).
  Code: 2*MaxValue[75*Cos[x]+115*Cos[x+1],x] = 338.68*/
  stroke(#FF0000);
  
  // x, y, w, h
  ellipse(225, 600, diam, diam);
  
  /*Draw the axis lines.*/
  stroke(#000000);
  line(10, 400, 440, 400);
  line(225, 0, 225, 400);
  line(225, 420, 225, 790);
  line(10, 600, 440, 600);
  
  /*Calculate the value of function and draw them*/
  calc(angle);
  strokeWeight(1.5);
  for(int a = 1; a < 400; a++){
    stroke(#FF0000);
    line(225 + X1[a], 400 - a, 225 + X1[a-1], 401 - a);

    stroke(#0000FF);
    line(225 + X2[a] + X1[a], 400-a, 225 + X2[a-1] + X1[a - 1], 401-a);
  }

  // points on circles
  float[] x = new float[10];
  float[] y = new float[10];
  
  x[0] = 225 + X1[0];
  y[0] = 600 + Y1[0];
  x[1] = x[0] + radius/3 * cos(angle * 3);
  y[1] = y[0] + radius/3 * sin(angle * 3);
  
  ellipse(x[0], y[0], diam/3, diam/3);

  // gray vert. line to lower x axis.
  stroke(#555555);
  line(x[0], 600, x[0], y[0]);
  line(x[1], 600, x[1], y[1]);

  
  fill(#FF0000);
  stroke(#FF0000);
  ellipse(x[0], 400, 7, 7);
  ellipse(x[0], 600, 7, 7);
  // red line connecting the lower and upper red dots.
  line(x[0], 400, x[0], 600);

  fill(#0000FF);
  stroke(#0000FF);
  fill(#0000FF);
  ellipse(x[1], 400, 7, 7);
  ellipse(x[1], 600, 7, 7);
  line(x[1], 400, x[1], 600);

  stroke(#0000FF);
  fill(#FF00FF);

  strokeWeight(2);
  stroke(#000000);
  
  // radius lines
  line(225, 600, x[0], y[0]);
  line(x[0], y[0], x[1], y[1]);
  fill(#0000FF);
  
  strokeWeight(1);
  angle -= 0.04;
    
  fill(#FFFFFF);
  //saveFrame("draw-####.png");
}

void calc(float ang) {
  for(int a = 0; a < 400; a++) {
    float theta = a * 0.01 + ang;
    X1[a] = radius * cos(theta);
    Y1[a] = radius * sin(theta);
    
    // float theta1 = 3 * a * 0.01 + ang;
    float theta1 = 3 * theta;
    X2[a] = radius/3 * cos(theta1);
    Y2[a] = radius/3 * sin(theta1);
 }
}