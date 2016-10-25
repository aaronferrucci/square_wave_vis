int num_harmonics = 3;
float[][] X = new float[num_harmonics][400];
float[][] Y = new float[num_harmonics][400];

float angle = 0;
int diam = 250;
int radius = diam/2;

void setup(){
  size(870, 800, OPENGL);
}

void draw() {
  background(#FFFFFF);

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
    if (harmonic == num_harmonics - 1)
      stroke(#0000FF);

    ellipse(centerx, centery, diam/amp, diam/amp);
    amp += 2;
  }

  calc(angle);
  strokeWeight(1.5);
  for(int a = 1; a < 400; a++) {
    // Upper trend lines
    float startx = 0, endx = 0;
    stroke(#FF0000);
    for (int harmonic = 0; harmonic < num_harmonics; ++harmonic) {
      startx += X[harmonic][a];
      endx += X[harmonic][a - 1];
 
      if (harmonic == num_harmonics - 1)
        stroke(#0000FF);
      line(225 + startx, 400 - a, 225 + endx, 401 - a);
    }

    float starty = 0, endy = 0;
    stroke(#FF0000);
    for (int harmonic = 0; harmonic < num_harmonics; ++harmonic) {
      starty += Y[harmonic][a];
      endy += Y[harmonic][a - 1];
      if (harmonic == num_harmonics - 1)
        stroke(#0000FF);
      line(450 + a, 600 + starty, 451 + a, 600 + endy);
    }
  }


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

  // dots for the right-hand projection
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
  angle -= 0.02;
    
  fill(#FFFFFF);
  //saveFrame("draw-####.png");
}

void calc(float ang) {
  int amp = 1;

  for (int harmonic = 0; harmonic < num_harmonics; ++harmonic) {
    for(int a = 0; a < 400; a++) {
      float theta = a * 0.01 + ang;
      X[harmonic][a] = radius * cos(amp * theta) / amp;
      Y[harmonic][a] = radius * sin(amp * theta) / amp;
    }
    amp += 2;
  }
}