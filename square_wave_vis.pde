float[] X1 = new float[400];
float[] Y1 = new float[400];
float[] X2 = new float[400];
float[] Y2 = new float[400];
float[] X3 = new float[400];
float[] Y3 = new float[400];
float angle = 0;
int diam = 150;
int radius = diam/2;
int ind = 0;

void setup(){
  size(870, 800, OPENGL);
  
}

void draw() {
  background(#FFFFFF);

  ellipseMode(CENTER);
  stroke(#FF0000);

  // points on circles
  float[] x = new float[10];
  float[] y = new float[10];
  
  x[0] = 225 + X1[0];
  y[0] = 600 + Y1[0];
  x[1] = x[0] + radius/3 * cos(angle * 3);
  y[1] = y[0] + radius/3 * sin(angle * 3);
  x[2] = x[1] + radius/5 * cos(angle * 5);
  y[2] = y[1] + radius/5 * sin(angle * 5);

  // x, y, w, h
  ellipse(225, 600, diam, diam);
  ellipse(x[0], y[0], diam/3, diam/3);
  
  /*Draw the axis lines.*/
  stroke(#000000);
  // upper horizontal projection line
  line(10, 400, 440, 400);
  // upper vertical axis
  line(225, 0, 225, 400);
  // lower vertical axis
  line(225, 420, 225, 790);
  // lower horizontal axis
  line(10, 600, 440, 600);
  
  // right horizontal axis
  line(450, 600, 850, 600);
  // right vertical projection line
  line(450, 420, 450, 790);
  
  /*Calculate the value of function and draw them*/
  calc(angle);
  strokeWeight(1.5);
  for(int a = 1; a < 400; a++){
    // Upper trend lines
    stroke(#FF0000);
    line(225 + X1[a], 400 - a, 225 + X1[a-1], 401 - a);
    line(225 + X2[a] + X1[a], 400-a, 225 + X2[a-1] + X1[a - 1], 401-a);

    stroke(#0000FF);
    line(225 + X3[a] + X2[a] + X1[a], 400-a, 225 + X3[a - 1] + X2[a-1] + X1[a - 1], 401-a);
    
    // right-hand trend lines
    stroke(#FF0000);
    line(450 + a, 600 + Y1[a], 451 + a, 600 + Y1[a-1]);
    line(450 + a, 600 + Y2[a] + Y1[a], 451 + a, 600 + Y2[a-1] + Y1[a-1]);

    stroke(#0000FF);
    line(450 + a, 600 + Y3[a] + Y2[a] + Y1[a], 451 + a, 600 + Y3[a - 1] + Y2[a-1] + Y1[a-1]);
  }

  stroke(#0000FF);
  ellipse(x[1], y[1], diam/5, diam/5);

  // gray vert. line to lower x axis.
  stroke(#555555);
  line(x[0], 600, x[0], y[0]);
  line(x[1], 600, x[1], y[1]);
  line(x[2], 600, x[2], y[2]);
  
  // and to lower y axis
  line(225, y[0], x[0], y[0]);
  line(225, y[1], x[1], y[1]);
  line(225, y[2], x[2], y[2]);

  fill(#FF0000);
  stroke(#FF0000);
  ellipse(x[0], 400, 7, 7);
  ellipse(x[0], 600, 7, 7);
  ellipse(x[1], 400, 7, 7);
  ellipse(x[1], 600, 7, 7);

  // red lines connecting the lower and upper red dots.
  line(x[0], 400, x[0], 600);
  line(x[1], 400, x[1], 600);

  // dots for the right-hand project
  ellipse(225, y[0], 7, 7);
  ellipse(450, y[0], 7, 7);
  ellipse(225, y[1], 7, 7);
  ellipse(450, y[1], 7, 7);

  line(225, y[0], 450, y[0]);
  line(225, y[1], 450, y[1]);

  stroke(#0000FF);
  fill(#0000FF);

  // upper
  ellipse(x[2], 400, 7, 7);
  ellipse(x[2], 600, 7, 7);
  line(x[2], 400, x[2], 600);

  // right
  ellipse(225, y[2], 7, 7);
  ellipse(450, y[2], 7, 7);
  line(225, y[2], 450, y[2]);

  stroke(#0000FF);
  fill(#FF00FF);

  strokeWeight(2);
  stroke(#000000);
  
  // radius lines
  line(225, 600, x[0], y[0]);
  line(x[0], y[0], x[1], y[1]);
  line(x[1], y[1], x[2], y[2]);
  fill(#0000FF);
  
  strokeWeight(1);
  angle -= 0.03;
    
  fill(#FFFFFF);
  //saveFrame("draw-####.png");
}

void calc(float ang) {
  for(int a = 0; a < 400; a++) {
    float theta = a * 0.01 + ang;
    X1[a] = radius * cos(theta);
    Y1[a] = radius * sin(theta);
    
    float theta3 = 3 * theta;
    X2[a] = radius/3 * cos(theta3);
    Y2[a] = radius/3 * sin(theta3);

    float theta5 = 5 * theta;
    X3[a] = radius/5 * cos(theta5);
    Y3[a] = radius/5 * sin(theta5);
  }
}