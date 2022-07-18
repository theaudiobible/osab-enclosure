/*
button-modules.scad - Button modules for the OSAB enclosure.

OSAB - the Open Source Audio Bible player.

Copyright (C) 2011-2022 Theophilus (http://theaudiobible.org)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/


include <vars.scad>;

module cf(height = 1, scale = 1)
 linear_extrude(height, scale = scale, center = true, $fn = 100) children();

// Triangular_button
module triangular_button_profile(side_length, corner_radius) {
  hull() {
    a = sqrt(3)/4*side_length;
    translate([-a, -side_length/2, 0])
      circle(corner_radius);
    translate([a, 0, 0])
      circle(corner_radius);
    translate([-a, side_length/2, 0])
      circle(corner_radius);
  }
}
module triangular_button_cutter(side_length, corner_radius, height) {
  linear_extrude(height=height, center=true, convexity=10, twist=0, scale=1)
  difference() {
    triangular_button_profile(side_length+2*shim, corner_radius);
    triangular_button_profile(side_length, corner_radius);
  }
}
module triangular_button(side_length, corner_radius, height) {
  h2 = radius - switch_button_diam/2;
  h1 = height - h2;
  translate([0, 0, -thickness/2])
    linear_extrude(height=thickness, center=true, convexity=10, twist=0, scale=1)
      triangular_button_profile(side_length, corner_radius);
  translate([0, 0, h1/2])
    linear_extrude(height=h1, center=true, convexity=10, twist=0, scale=1)
      triangular_button_profile(side_length+1, corner_radius);
  translate([0, 0, (height+h1)/2])
    linear_extrude(height=h2, center=true, convexity=10, twist=0, scale=0.5)
      triangular_button_profile(side_length+1, corner_radius);
}


// Square button
module square_button_profile(side_length, corner_radius) {
  hull() {
    translate([-side_length/2, -side_length/2, 0])
      circle(corner_radius);
    translate([side_length/2, -side_length/2, 0])
      circle(corner_radius);
    translate([side_length/2, side_length/2, 0])
      circle(corner_radius);
    translate([-side_length/2, side_length/2, 0])
      circle(corner_radius);
    }
}
module square_button_cutter(side_length, corner_radius, height) {
  linear_extrude(height=height, center=true, convexity=10, twist=0, scale=1)
  difference() {
    square_button_profile(side_length+2*shim, corner_radius);
    square_button_profile(side_length, corner_radius);
  }
}
module square_button(side_length, corner_radius, height) {
  h2 = corner_radius + side_length/2 - switch_button_diam/2;
  h1 = height - h2;
  translate([0, 0, -thickness/2])
    linear_extrude(height=thickness, center=true, convexity=10, twist=0, scale=1)
      square_button_profile(side_length, corner_radius);
  translate([0, 0, h1/2])
    linear_extrude(height=h1, center=true, convexity=10, twist=0, scale=1)
      square_button_profile(side_length+1, corner_radius);
  translate([0, 0, (height+h1)/2])
    linear_extrude(height=h2, center=true, convexity=10, twist=0, scale=0.5)
      square_button_profile(side_length+1, corner_radius);
}


// Round button
module round_button_profile(radius) {
  circle(r=radius);
}
module round_button_cutter(radius, height) {
  linear_extrude(height=height, center=true, convexity=10, twist=0, scale=1)
  difference() {
    round_button_profile(radius+shim);
    round_button_profile(radius);
  }
}
module round_button(radius, height) {
  h2 = radius - switch_button_diam/2;
  h1 = height - h2;
  translate([0, 0, -thickness/2])
    cylinder(r=radius, h=thickness, center=true);
  translate([0, 0, h1/2])
    linear_extrude(height=h1, center=true, convexity=10, twist=0, scale=1)
      circle(r=radius+0.5);
  translate([0, 0, h1 + h2/2])
    linear_extrude(height=h2, center=true, convexity=10, twist=0, scale=0.5)
      circle(r=radius+0.5);
}


// Connecting strip
module strip(x1, y1, x2, y2, width, height) {
  a = x2 - x1;
  o = y2 - y1;
  p = 45;  // Chamfer angle
  tanp = tan(p);
  cotp = 1/tanp;
  h = sqrt(o*o + a*a);
  sinq = o/h;
  cosq = a/h;
  polyhedron(points = [
              [x1 - sinq*width/2, y1 + cosq*width/2, height/2],
              [x2 - sinq*width/2, y2 + cosq*width/2, height/2],
              [x2 + sinq*width/2, y2 - cosq*width/2, height/2],
              [x1 + sinq*width/2, y1 - cosq*width/2, height/2],
              [x1 - sinq*width/2 - (height/tanp)*sinq, y1 + cosq*width/2 + (height/cotp)*cosq, -height/2],
              [x2 - sinq*width/2 - (height/tanp)*sinq, y2 + cosq*width/2 + (height/cotp)*cosq, -height/2],
              [x2 + sinq*width/2 + (height/tanp)*sinq, y2 - cosq*width/2 - (height/cotp)*cosq, -height/2],
              [x1 + sinq*width/2 + (height/tanp)*sinq, y1 - cosq*width/2 - (height/cotp)*cosq, -height/2]],
             faces = [
              [0,1,2,3],   // bottom
              [4,5,1,0],   // front
              [7,6,5,4],   // top
              [5,6,2,1],   // right
              [6,7,3,2],   // back
              [7,4,0,3]]); // left
}
