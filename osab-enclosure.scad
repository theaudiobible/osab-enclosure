/*
osab-enclosure.scad - the OSAB enclosure.

OSAB - the Open Source Audio Bible player.

Copyright (C) 2011-2021 Theophilus (http://theaudiobible.org)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FI
*/

// begin outershell
module outershell(width, length, height) {
  union() {
    cube([width-height, height, length], center=true);
    translate([(width-height)/2, 0, 0])
      cylinder(h = length, d = height, center=true);
    translate([-(width-height)/2, 0, 0])
      cylinder(h = length, d = height, center=true);
  }
}
// end outershell

// begin shell
// width, length, height for inner dims
module shell(width, length, height, thickness) {
  union() {
    difference() {
      outershell(width+thickness, length, height+thickness);
      outershell(width, length+shim, height);
    }
    difference() {
      union() {
        translate([(width-height)/2, 0, 0])
          cylinder(h = length, d = height, center=true);
        translate([-(width-height)/2, 0, 0])
          cylinder(h = length, d = height, center=true);
      }
      cube([(width-3), height, length+shim], center=true);
      difference() {
        outershell(width, length+shim, height);
        translate([0, height/4, 0])
          cube([width*2, height/2-pcb_thickness, length+shim], center=true);
        translate([0, -height/4, 0])
          cube([width*2, height/2-pcb_thickness, length+shim], center=true);
      }
    }
    translate([0, 0, (length - thickness)/2])
      outershell(width+thickness/2, thickness, height+thickness);
  }
}
// end shell

// begin speaker retainer
module speaker_retainer() {
  difference() {
    union() {
      translate([0, 0, (speaker_bot_ht-thickness)/2])
      difference() {
        cylinder(h=speaker_bot_ht, d=speaker_bot_diam+2*thickness, center=true);
        cylinder(h=speaker_bot_ht+shim, d=speaker_bot_diam, center=true);
      }
      translate([0, 0, speaker_bot_ht])
        difference() {
          cylinder(h=thickness, d=speaker_bot_diam+2*thickness, center=true);
          cylinder(h=thickness+shim, d=speaker_mid_diam, center=true);
        }
    }
    translate([0, (speaker_bot_diam+2*thickness)/4, 0])
      cube([speaker_bot_diam+2*thickness, (speaker_bot_diam+2*thickness)/2, 5*thickness], center=true);
  }
}
// end speaker retainer

// begin speaker retainer corner

// end speaker retainer corner

// begin triangular_button
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
module triangular_button(side_length, corner_radius, height) {
  translate([0, 0, -height/4])
    linear_extrude(height=height/2, center=true, convexity=10, twist=0, scale=1)
    triangular_button_profile(side_length, corner_radius);
  translate([0, 0, height/4])
    linear_extrude(height=height/2, center=true, convexity=10, twist=0, scale=1)
    triangular_button_profile(side_length+1, corner_radius);
}
// end triangular_button


// begin square button
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
module square_button(side_length, corner_radius, height) {
  translate([0, 0, -height/4])
    linear_extrude(height=height/2, center=true, convexity=10, twist=0, scale=1)
      square_button_profile(side_length, corner_radius);
  translate([0, 0, height/4])
    linear_extrude(height=height/2, center=true, convexity=10, twist=0, scale=1)
      square_button_profile(side_length+1, corner_radius);
}
// end square button

// begin round button
module round_button(radius, height) {
  union() {
    translate([0, 0, -height/4])
      cylinder(r=radius, h=height/2, center=true);
    translate([0, 0, height/4])
      linear_extrude(height=height/2, center=true, convexity=10, twist=0, scale=1)
        circle(r=radius+0.5);
  }
}
// end round button



// begin connecting strip
module strip(x1, y1, x2, y2, width, height) {
  a = x2 - x1;
  o = y2 - y1;
  h = sqrt(o*o + a*a);
  sinq = o/h;
  cosq = a/h;
  linear_extrude(height = height, center = true)
    polygon(points = [[x1 - sinq*width/2, y1 + cosq*width/2], [x2 - sinq*width/2, y2 + cosq*width/2], [x2 + sinq*width/2, y2 - cosq*width/2], [x1 + sinq*width/2, y1 - cosq*width/2]]);
}
// end connecting strip


$fa=0.5; // default minimum facet angle is now 0.5
$fs=0.5; // default minimum facet size is now 0.5 mm


thickness = 2;
pcb_width = 50;
height = 12;
width = pcb_width;
length = width*(1+sqrt(5))/2;
pcb_length = length - 2*thickness;
pcb_thickness = 1.0;
hole_depth = 8*thickness;
shim = 0.2;
radius = 5;
center = width/2;
dimple = 1.2;
speaker_top_diam = 16;
speaker_mid_diam = 27.5;
speaker_bot_diam = 30;
speaker_top_ht = 1.5;
speaker_mid_ht = 1.1;
speaker_bot_ht = 2.4;
speaker_hole_diameter = 2;
speaker_hole_height = 4*thickness;
cat_button_x = 15;
cat_button_y = 17;
vol_button_x = 15;
vol_button_y = 17;
switch_height = 1.5;
//button_height = 9 - 2*switch_height - shim;
button_height = 4;
button_gap = 14;
strip_width = 3;
strip_height = 1;
earphone_diam = 5;
earphone_height = 2.3;
earphone_to_pcb_right = 19.25;
usb_width = 9;
usb_height = 3.2;
pinhole_diameter = 1.2;
lock_to_pcb_left = 11.5;
lock_hole_width = 2.15+2;
lock_lever_altitude = 0.4;
lock_lever_depth = 1.5;
lock_lever_width = 1.3;
lock_support_width = 10;
lock_support_thickness = 1;
lock_support_height = height/2 - thickness;
lock_ext_width = lock_support_width*2/3;
lock_ext_depth = 4*thickness;
lock_ext_thickness = 2;
text_depth = 1;

// begin - Front shell
*union() {
  difference() {
      shell(thickness = thickness, width = width, length = length, height = height);

      // Earphone socket hole
      translate([-(width-height)/2, 0, length/2])
          cylinder(h=hole_depth, d=earphone_diam+3*shim, center=true);

      // USB-C socket hole
      translate([0, 0, length/2])
          union() {
              rotate([90, 0, 0])cube([usb_width-usb_height+2*shim, hole_depth, usb_height], center=true);
              translate([(usb_width-usb_height+2*shim)/2, 0, 0])cylinder(h=hole_depth, d=usb_height, center=true);
              translate([-(usb_width-usb_height+2*shim)/2, 0, 0])cylinder(h=hole_depth, d=usb_height, center=true);
          }

      // Button lock hole - move to bottom?
      // translate([-width/2, 0, length/2])
      //   cube([lock_hole_width, lock_ext_thickness+shim, hole_depth], true);

      rotate([-90, 0, 0])
      translate([-width/2, -length/3, -thickness-height/2]) {
      // PPP button hole
        translate([center, center, thickness+shim])
          rotate([0, 0, 0])
            triangular_button(7+5*shim, 2, button_height);

      // Chap+ button
        translate([center+button_gap, center, thickness+shim])
          square_button(5+4*shim, 2, button_height);

      // Chap- button
        translate([center-button_gap, center, thickness+shim])
          square_button(5+4*shim, 2, button_height);

      // Book- button
        translate([center, center+button_gap, thickness+shim])
          square_button(5+4*shim, 2, button_height);

      // Book+ button
        translate([center, center-button_gap, thickness+shim])
          square_button(5+4*shim, 2, button_height);

      // Category button
          translate([center+cat_button_x, center-cat_button_y, thickness+shim])
            round_button(4+2*shim, button_height);

      // Vol- button
          translate([center-vol_button_x, center+vol_button_y, thickness+shim])
            round_button(4+2*shim, button_height);

      // Vol+ button
          translate([center+vol_button_x, center+vol_button_y, thickness+shim])
            round_button(4+2*shim, button_height);
      }

      // Speaker holes
      translate([0, 0, -(length+thickness)/4])
       rotate([90, 0, 0]) {
        r = 3;
        for (Q = [0:60:300]) {
          translate([r*cos(Q), r*sin(Q), -speaker_hole_height])cylinder(h=speaker_hole_height, d=speaker_hole_diameter, center=true);
        }
        rad = 7.5;
        for (Q = [0:20:340]) {
          translate([rad*cos(Q), rad*sin(Q), -speaker_hole_height])
            cylinder(h=speaker_hole_height, d=speaker_hole_diameter, center=true);
          }
        rd = 12;
        for (Q = [0:15:345]) {
          translate([rd*cos(Q), rd*sin(Q), -speaker_hole_height])cylinder(h=speaker_hole_height, d=speaker_hole_diameter, center=true);
        }
      }

      // Logo
      translate([width/4 + 2, length*3/4, 0])
        rotate([180,0,0])
          linear_extrude(height = text_depth, center = true)
            text("OSAB", size = 8, font="Stardos Stencil:style=Regular");
  }


  // Button lock support
  difference() {
    translate([(width-height-thickness/2)/2, thickness-height/2, lock_ext_depth-length/2])
      rotate([90, 0, 180])
          union() {
            cube([lock_support_width, lock_support_thickness, lock_support_height], true);
            translate([0, 0, lock_support_height/2])
              rotate([0, 90, 0])
                cylinder($fn=40, h=lock_support_width, d=lock_support_thickness, center=true);
          }
    difference() {
      outershell(width+5*thickness, length, height+5*thickness);
      outershell(width, length+shim, height);
    }
  }

  // Speaker retainer
  translate([0, (height-thickness)/2, -(length+thickness)/4])
    rotate([-90, 0, 180])
      speaker_retainer();
}
// end - Front shell



// Plug
#union() {
  translate([0, 0, thickness-length/2])
    difference() {
      outershell(width, 2*thickness, height);
      translate([0, 0, -thickness])
        outershell(width-thickness, 2*thickness, height-thickness);
    }
  translate([0, (height-thickness)/2, -(length+thickness)/4])
    rotate([90, 0, 0])
      speaker_retainer();
}



// Buttons
rotate([-90, 0, 0])
translate([-width/2, -length/3, -thickness-height/2]) {
    // PPP button
    color("red")
      translate([center, center, thickness])
        rotate([0, 0, 0])
            triangular_button(7, 2, button_height);

    // Chap+ button
    color("orange")
      translate([center+button_gap, center, thickness])
        square_button(5, 2, button_height);

    // Chap- button
    color("orange")
      translate([center-button_gap, center, thickness]) 
        square_button(5, 2, button_height);

    // Book- button
    color("brown")
      translate([center, center+button_gap, thickness])
        square_button(5, 2, button_height);

    // Book+ button
    color("brown")
      translate([center, center-button_gap, thickness])
        square_button(5, 2, button_height);

    // Category button
    color ("grey")
      translate([center+cat_button_x, center-cat_button_y, thickness])
        round_button(4, button_height);

    // Vol- button
    color("blue")
      translate([center-vol_button_x, center+vol_button_y, thickness])
        round_button(4, button_height);

    // Vol+ button
    color("blue")
      translate([center+vol_button_x, center+vol_button_y, thickness])
        round_button(4, button_height);

    translate([0, 0, button_height-strip_height/2]) {
      strip(center, center, center+vol_button_x, center+vol_button_y, strip_width, strip_height);

      strip(center, center, center-vol_button_x, center+vol_button_y, strip_width, strip_height);

      strip(center, center, center+cat_button_x, center-cat_button_y, strip_width, strip_height);

      strip(center, center+button_gap, center+vol_button_x, center+vol_button_y, strip_width, strip_height);

      strip(center, center+button_gap, center-vol_button_x, center+vol_button_y, strip_width, strip_height);

      strip(center+button_gap, center, center+vol_button_x, center+vol_button_y, strip_width, strip_height);

      strip(center+button_gap, center,center+cat_button_x, center-cat_button_y, strip_width, strip_height);

      strip(center-vol_button_x, center+vol_button_y, center-button_gap, center, strip_width, strip_height);

      strip(center-button_gap, center, center, center-button_gap, strip_width, strip_height);
    }
}


// PCB
*translate([width/2, pcb_length/2-(radius-(thickness+shim)), pcb_thickness+thickness]) {
  rotate([0, 180, 180]) {
    import("osab.stl", convexity=10);
  }
}


// Button lock extension
rotate([90, 0, 180])
translate([-(width-height+thickness+2*shim)/2, lock_ext_depth-length/2, pcb_thickness/2-lock_ext_thickness])
  difference() {
    union() {
      cube([lock_ext_width, lock_ext_depth, lock_ext_thickness], true);
      translate([0, -radius/sqrt(2), 0])
        minkowski() {
          cube([1, radius, lock_ext_thickness/2], true);
          cylinder(h=1, d=1, center=true);
        }
    }
    translate([0, (lock_ext_depth-lock_lever_depth)/2, 0])
      cube([lock_lever_width+shim, lock_lever_depth+shim, lock_ext_thickness+shim], true);
    translate([0, 0, -lock_ext_thickness/4])
      cube([lock_support_width, lock_support_thickness+shim, lock_ext_thickness/2+shim], true);
}


// Lithium Battery
color("grey")
  translate([0, height/4, length/5])
    cube([38, 6, 25], center=true);


// simPCB
color("green")
  rotate([90, 0, 0])
    cube([width, pcb_length, pcb_thickness], center=true);


// simCardHolder
holder_width = 15.35;
holder_length = 14.5;
holder_height = 2.45;
card_width = 11.05;
card_length = 2.65;
card_height = 1.00;
translate([(height-width)/3, -holder_height/2, card_length/2+shim-length/2.5]) {
  rotate([90, 180, 0]) {
    color("grey")
      cube([holder_width, holder_length, holder_height], center=true);
      color("red")
        translate([1.5, holder_length/2, 0.5])
          cube([card_width, card_length, card_height], center=true);
  }
}


// Speaker
translate([0, (height-thickness)/2, -(length+thickness)/4])
  rotate([90, 0, 0])
    {
      %color("grey") {
        cylinder(h=speaker_bot_ht, d=speaker_bot_diam, center=true);
        translate([0, 0, (speaker_bot_ht+speaker_mid_ht)/2])
          cylinder(h=speaker_mid_ht, d=speaker_mid_diam, center=true);
        translate([0, 0, (speaker_bot_ht+speaker_mid_ht+speaker_top_ht)/2])
          cylinder(h=speaker_top_ht, d=speaker_top_diam, center=true);
      }
    }

