
int num_harmonics = 6;
int num_points = 400;
float[][] X = new float[num_harmonics][num_points];
float[][] Y = new float[num_harmonics][num_points];
boolean drawing = true;

float rotation = 0.0;
float angle = 0;
float diam = 200;
float radius = diam/2;

void setup(){
  size(870, 800, OPENGL);
}

void draw() {
  background(#FFFFFF);
  
  //textSize(128);
  //fill(#000000);
  //text(1 + (num_harmonics - 1) * 2, 600, 200);

  strokeWeight(1);
  fill(#FFFFFF);

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

  ellipseMode(CENTER);
  stroke(#FF0000);

  // points on circles
  float[] x = new float[num_harmonics];
  float[] y = new float[num_harmonics];
  
  float centerx = 225;
  float centery = 600;
  int amp = 1;
  for (int harmonic = 0; harmonic < num_harmonics; ++harmonic) {
    x[harmonic] = centerx + radius * cos(angle * amp) / amp;
    y[harmonic] = centery + radius * sin(angle * amp) / amp;
    
    amp += 2;
    centerx = x[harmonic];
    centery = y[harmonic];
  }

  // Draw the circles. The first one is stationary; the others' centers
  // are on the next-larger circle's circumference.
  amp = 1;
  for (int harmonic = 0; harmonic < num_harmonics; ++harmonic) {
    if (harmonic == 0) {
      centerx = 225;
      centery = 600;
    } else {
      centerx = x[harmonic - 1];
      centery = y[harmonic - 1];
    }
    if (harmonic == num_harmonics - 1) {
      stroke(#0000FF);
      strokeWeight(2);
    }

    ellipse(centerx, centery, diam/amp, diam/amp);
    amp += 2;
  }

  calc(angle);
  for(int a = 1; a < num_points; a++) {
    // Upper trend lines
    float startx = 0, endx = 0;
    stroke(#FF0000);
    strokeWeight(1);
    for (int harmonic = 0; harmonic < num_harmonics; ++harmonic) {
      startx += X[harmonic][a];
      endx += X[harmonic][a - 1];
 
      if (harmonic == num_harmonics - 1) {
        strokeWeight(2);
        stroke(#0000FF);
      }
      line(225 + startx, 400 - a, 225 + endx, 401 - a);
    }

    // Right-hand trend lines
    float starty = 0, endy = 0;
    stroke(#FF0000);
    strokeWeight(1);
    for (int harmonic = 0; harmonic < num_harmonics; ++harmonic) {
      starty += Y[harmonic][a];
      endy += Y[harmonic][a - 1];
      if (harmonic == num_harmonics - 1) {
        strokeWeight(2);
        stroke(#0000FF);
      }
      line(450 + a, 600 + starty, 451 + a, 600 + endy);
    }
  }

  // lines from lower x,y axes to projection lines
  fill(#FF0000);
  stroke(#FF0000);
  strokeWeight(1);
  for (int harmonic = 0; harmonic < num_harmonics; ++harmonic) {
    if (harmonic == num_harmonics - 1) {
      stroke(#0000FF);
      fill(#0000FF);
    }

    // dots for the upper projection
    ellipse(x[harmonic], 400, 7, 7);
    ellipse(x[harmonic], 600, 7, 7);
    // red lines connecting the lower and upper red dots.
    line(x[harmonic], 400, x[harmonic], 600);

    ellipse(225, y[harmonic], 7, 7);
    ellipse(450, y[harmonic], 7, 7);
    line(225, y[harmonic], 450, y[harmonic]);
  }

  // lines from circle intersections to lower x, y axes
  // consider drawing these later, to overwrite projection lines.
  strokeWeight(1);
  stroke(#555555);
  for (int harmonic = 0; harmonic < num_harmonics; ++harmonic) {
    // gray vert. line to lower x axis.
    line(x[harmonic], 600, x[harmonic], y[harmonic]);
    // and to lower y axis
    line(225, y[harmonic], x[harmonic], y[harmonic]);
  }

  // radius lines
  strokeWeight(2.5);
  stroke(#000000);
  
  centerx = 225;
  centery = 600;
  for (int harmonic = 0; harmonic < num_harmonics; ++harmonic) {
    line(centerx, centery, x[harmonic], y[harmonic]);
  
    centerx = x[harmonic];
    centery = y[harmonic];
  }
  
  float delta = 2*PI / 628;
  angle -= delta;
  rotation += delta;
  
  if (drawing) {
    if (rotation > 2*PI)
      exit();
  
    saveFrame("draw-####.png");
  }
}

void calc(float ang) {
  int amp = 1;

  for (int harmonic = 0; harmonic < num_harmonics; ++harmonic) {
    for(int a = 0; a < num_points; a++) {
      float theta = a * 0.01 + ang;
      X[harmonic][a] = radius * cos(amp * theta) / amp;
      Y[harmonic][a] = radius * sin(amp * theta) / amp;
    }
    amp += 2;
  }
}