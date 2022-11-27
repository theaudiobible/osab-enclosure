/*
button-modules.scad - Button modules for the OSAB enclosure.

OSAB - the Open Source Audio Bible player.

Copyright (C) 2011-2022 Theophilus (http://theaudiobible.org)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/


include <vars.scad>;


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

module triangular_button_rim(side_length, corner_radius, width) {
  linear_extrude(height=width, center=true, convexity=10, twist=0, $fn=40, scale=1)
  difference() {
    triangular_button_profile(side_length + layer_height, corner_radius);
    triangular_button_profile(side_length - layer_height, corner_radius);
  }
}

module triangular_button_support(side_length, corner_radius, layer_height, layer_width) {
  if (layer_width < thickness/2) {
    triangular_button_rim(side_length, corner_radius, layer_width);
    triangular_button_support(side_length - layer_height, corner_radius - layer_height*2/5, layer_height, layer_width + layer_height);
  } else {
    linear_extrude(height=thickness/2, center=true, convexity=10, twist=0, $fn=40, scale=1)
      triangular_button_profile(side_length + layer_height, corner_radius);
  }
}

module triangular_button_cutter(side_length, corner_radius, height) {
  linear_extrude(height=height, center=true, convexity=10, twist=0, $fn=40, scale=1)
    triangular_button_profile(side_length, corner_radius);
}

module triangular_extrusion(side_length, corner_radius, height, scale_) {
  linear_extrude(height=height, center=true, convexity=10, twist=0, $fn=40, scale=scale_)
    triangular_button_profile(side_length, corner_radius);
}

module triangular_clip(side_length, corner_radius, height, scale_) {
  difference() {
    triangular_extrusion(side_length, corner_radius, height, scale_);
    translate([0, 0, -button_base])
      triangular_extrusion(side_length*3/4, corner_radius, height, scale_);
      translate([0, 0, -button_base]) {
        cube([0.5, 3*side_length, height], center=true);
        cube([3*side_length, 0.5, height], center=true);
      }
  }
}

module triangular_ring(side_length, corner_radius, height, thickness) {
  linear_extrude(height=height, center=true, convexity=10, twist=0, $fn=40) {
    difference() {
      triangular_button_profile(side_length, corner_radius);
      triangular_button_profile(side_length - 2*thickness, corner_radius);
    }
  }
}

module triangular_tapered_ring(side_length, corner_radius, height, thickness) {
  difference() {
    triangular_extrusion(side_length, corner_radius, height, 1);
    translate([0, 0, -layer_height])
      triangular_extrusion(side_length - thickness/2, corner_radius, height, 0.7);
    translate([0, 0, (height - 2*layer_height)/2])
      triangular_extrusion(2*side_length, corner_radius, 2*layer_height + 0.01, 1);
  }
}

module triangular_button(side_length, corner_radius, height) {
  translate([0, 0, -thickness*3/8])
    triangular_tapered_ring(side_length + 2, corner_radius, thickness*3/4, nozzle_diam);
  translate([0, 0, -thickness*9/8])
    triangular_ring(side_length + 2, corner_radius, thickness*3/4, nozzle_diam);
  translate([0, 0, -thickness*9/8])
    triangular_extrusion(side_length, corner_radius, thickness*3/4, 1);
  translate([0, 0, -thickness*3/8])
    triangular_extrusion(side_length, corner_radius, thickness*3/4, 0.5);
  translate([0, 0, height/2])
    triangular_extrusion(side_length/2, corner_radius, height, 0.5);
  translate([0, 0, height/2])
    triangular_clip(side_length + 2, corner_radius, height, 0.5);
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

module square_button_rim(side_length, corner_radius, width) {
  linear_extrude(height=width, center=true, convexity=10, twist=0, $fn=40, scale=1)
  difference() {
    square_button_profile(side_length + layer_height, corner_radius);
    square_button_profile(side_length - layer_height, corner_radius);
  }
}

module square_button_support(side_length, corner_radius, layer_height, layer_width) {
  if (layer_width < thickness/2) {
    square_button_rim(side_length, corner_radius, layer_width);
    square_button_support(side_length - layer_height, corner_radius - layer_height*2/5, layer_height, layer_width + layer_height);
  } else {
    linear_extrude(height=thickness/2, center=true, convexity=10, twist=0, $fn=40, scale=1)
      square_button_profile(side_length + layer_height, corner_radius);
  }
}

module square_button_cutter(side_length, corner_radius, height) {
  linear_extrude(height=height, center=true, convexity=10, twist=0, $fn=40, scale=1)
    square_button_profile(side_length, corner_radius);
}

module square_extrusion(side_length, corner_radius, height, scale_) {
  linear_extrude(height=height, center=true, convexity=10, twist=0, $fn=40, scale=scale_)
    square_button_profile(side_length, corner_radius);
}

module square_clip(side_length, corner_radius, height, scale_) {
  difference() {
    square_extrusion(side_length, corner_radius, height, scale_);
    translate([0, 0, -button_base])
      square_extrusion(side_length*3/4, corner_radius, height, scale_);
      translate([0, 0, -button_base]) {
        cube([0.5, 3*side_length, height], center=true);
        cube([3*side_length, 0.5, height], center=true);
      }
  }
}

module square_ring(side_length, corner_radius, height, thickness) {
  linear_extrude(height=height, center=true, convexity=10, twist=0, $fn=40) {
    difference() {
      square_button_profile(side_length, corner_radius);
      square_button_profile(side_length - 2*thickness, corner_radius);
    }
  }
}

module square_tapered_ring(side_length, corner_radius, height, thickness) {
  difference() {
    square_extrusion(side_length, corner_radius, height, 1);
    translate([0, 0, -layer_height])
      square_extrusion(side_length - thickness/2, corner_radius, height, 0.7);
    translate([0, 0, (height - 2*layer_height)/2])
      square_extrusion(2*side_length, corner_radius, 2*layer_height + 0.01, 1);
  }
}

module square_button(side_length, corner_radius, height) {
  translate([0, 0, -thickness*3/8])
    square_tapered_ring(side_length + 2, corner_radius, thickness*3/4, nozzle_diam);
  translate([0, 0, -thickness*9/8])
    square_ring(side_length + 2, corner_radius, thickness*3/4, nozzle_diam);
  translate([0, 0, -thickness*9/8])
    square_extrusion(side_length, corner_radius, thickness*3/4, 1);
  translate([0, 0, -thickness*3/8])
    square_extrusion(side_length, corner_radius, thickness*3/4, 0.5);
  translate([0, 0, height/2])
    square_extrusion(side_length/2, corner_radius, height, 0.5);
  translate([0, 0, height/2])
    square_clip(side_length + 2, corner_radius, height, 0.5);
}


// Round button
module round_button_profile(radius) {
  circle(r=radius);
}

module round_button_rim(radius, width) {
  linear_extrude(height=width, center=true, convexity=10, twist=0, $fn=40, scale=1)
  difference() {
    round_button_profile(radius + layer_height);
    round_button_profile(radius);
  }
}

module round_button_support(radius, layer_height, layer_width) {
  if (layer_width < thickness/2) {
    round_button_rim(radius, layer_width);
    round_button_support(radius - layer_height, layer_height, layer_width + layer_height);
  } else {
    linear_extrude(height=thickness/2, center=true, convexity=10, twist=0, $fn=40, scale=1)
      round_button_profile(radius + layer_height);
  }
}

module round_button_cutter(radius, width) {
  linear_extrude(height=width, center=true, convexity=10, twist=0, $fn=40, scale=1)
    round_button_profile(radius);
}

module round_extrusion(radius, height, scale_) {
  linear_extrude(height=height, center=true, convexity=10, twist=0, $fn=40, scale=scale_)
    circle(r = radius);
}

module round_clip(radius, height, scale_) {
  difference() {
    round_extrusion(radius, height, scale_);
    translate([0, 0, -button_base])
      round_extrusion(radius*3/4, height, scale_);
      translate([0, 0, -button_base]) {
        cube([0.5, 3*radius, height], center=true);
        cube([3*radius, 0.5, height], center=true);
      }
  }
}

module round_ring(radius, height, thickness) {
  difference() {
    cylinder(r=radius, h=height, center=true);
    cylinder(r=radius - thickness, h=height + 1, center=true);
  }
}

module round_tapered_ring(radius, height, thickness) {
  difference() {
    cylinder(r=radius, h=height, center=true);
    translate([0, 0, -layer_height])
      round_extrusion(radius - thickness/2, height, 0.7);
    translate([0, 0, (height - 2*layer_height)/2])
      cylinder(r=2*radius, h=2*layer_height + 0.01, center=true);
  }
}

module round_button(radius, height) {
  translate([0, 0, -thickness*3/8])
    round_tapered_ring(radius + 1, thickness*3/4, nozzle_diam);
  translate([0, 0, -thickness*9/8])
    round_ring(radius + 1, thickness*3/4, nozzle_diam);
  translate([0, 0, -thickness*9/8])
    cylinder(r=radius + layer_height/2, h=thickness*3/4, center=true);
  translate([0, 0, -thickness*3/8])
    round_extrusion(radius, thickness*3/4, 0.5);
  translate([0, 0, height/2])
    round_extrusion(radius/2, height, 0.5);
  translate([0, 0, height/2])
    round_clip(radius + 1, height, 0.5);
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
