/*
osab-enclosure.scad - the OSAB enclosure.

OSAB - the Open Source Audio Bible player.

Copyright (C) 2011-2020 Theophilus (http://theaudiobible.org)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FI
*/

// begin shell
module shell(width, length, height, radius, thickness) {
  difference() {
    minkowski() {
      cube([width, length, height]);
      difference() {
        translate([0, 0, radius])
          sphere(radius);
        translate([-radius, -radius, radius])
          cube(2*radius);
      }
    }
    minkowski() {
      cube([width, length, height+thickness]);
      difference() {
        translate([0, 0, radius])
          sphere(radius-thickness);
        translate([-radius, -radius, radius])
          cube(2*radius);
      }
    }
  }
}
// end shell

// begin triangular_button
module triangular_button_profile(side_length, corner_radius) {
  hull() {
    translate([-side_length/2, -side_length/2, 0])
      circle(corner_radius);
    translate([side_length/2, -side_length/4, 0])
      circle(corner_radius);
    translate([-side_length/4, side_length/2, 0])
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


// begin PCB support clip
module clip(height=clip_height, width=clip_width, clip_thickness=clip_thickness, chin_height=clip_chin_height, chin_thickness=clip_chin_thickness, pcb_thickness=pcb_thickness) {
  linear_extrude(height = width)
    polygon(points = [[0, 0], [height, 0], [height, clip_thickness], [height-2, chin_thickness-0.5], [chin_height+pcb_thickness+shim, chin_thickness-0.5], [chin_height+pcb_thickness+shim, clip_thickness], [chin_height, clip_thickness], [chin_height, chin_thickness], [chin_height-1, chin_thickness], [chin_height-2, clip_thickness], [1, clip_thickness], [0, 3], [0, clip_thickness]]);
}
// end clip


// begin PCB mount
module pcb_mount(base_height, base_diameter, nipple_height, nipple_diameter) {
  translate([0, 0, base_height/2 + thickness]) {
    cylinder($fn=40, d=base_diameter, h=base_height, center=true);
    translate([0, 0, base_height/2 + nipple_height/2])
      cylinder($fn=40, d=nipple_diameter, h=nipple_height, center=true);
  }
}
// end PCB mount


// begin connecting strip
module strip(x1, y1, x2, y2, width, height) {
  a = x2 - x1;
  o = y2 - y1;
  h = sqrt(o*o + a*a);
  sinq = o/h;
  cosq = a/h;
  translate([0, 0, button_height - height/2 - thickness + shim/2])
    linear_extrude(height = height, center = true)
      polygon(points = [[x1 - sinq*width/2, y1 + cosq*width/2], [x2 - sinq*width/2, y2 + cosq*width/2], [x2 + sinq*width/2, y2 - cosq*width/2], [x1 + sinq*width/2, y1 - cosq*width/2]]);
}
// end connecting strip


$fa=0.5; // default minimum facet angle is now 0.5
$fs=0.5; // default minimum facet size is now 0.5 mm


pcb_width = 60;
pcb_length = 100;
pcb_thickness = 1.6;
thickness = 1.5;
hole_depth = 8*thickness;
shim = 0.2;
radius = 5;
width = pcb_width;
length = width*(1+sqrt(5))/2;
height = 10;
center = width/2;
dimple = 1.2;
speaker_diameter = 50;
cat_button_x = 20;
cat_button_y = 20;
vol_button_x = 20;
vol_button_y = 20;
clip_width = 5;
clip_height = 9;
clip_thickness = 2.5;
clip_chin_height = clip_height/2;
clip_chin_thickness = 1.5*clip_thickness;
mount_hole_offset = 4;
mount_base_height = clip_chin_height;
mount_base_diameter = 4;
mount_nipple_height = 1;
mount_nipple_diameter = 2.8;
switch_height = 1.5;
button_height = clip_height - 2*switch_height - shim;
button_gap = 15;
strip_width = 3;
strip_height = 1;
speaker_hole_diameter = 2;
speaker_hole_height = thickness+0.5;
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
lock_support_height = clip_chin_height - lock_lever_altitude - lock_support_thickness - shim;
lock_ext_width = lock_support_width*2/3;
lock_ext_depth = 7;
lock_ext_thickness = 2;
text_depth = 1;

// begin - Front shell
union() {
  difference() {
      shell(thickness = thickness, radius = radius, width = width, length = length, height = height);

      // Earphone socket hole
      translate([width-earphone_to_pcb_right, -radius, clip_chin_height+thickness-earphone_height])
        rotate([90, 0, 0])
          cylinder(h=hole_depth, d=earphone_diam+3*shim, center=true);

      // USB-C socket hole
      translate([width/2, -radius, clip_chin_height-shim])
        rotate([90, 0, 0])
          union() {
              rotate([90, 0, 0])cube([usb_width-usb_height+2*shim, hole_depth, usb_height], center=true);
              translate([(usb_width-usb_height+2*shim)/2, 0, 0])cylinder(h=hole_depth, d=usb_height, center=true);
              translate([-(usb_width-usb_height+2*shim)/2, 0, 0])cylinder(h=hole_depth, d=usb_height, center=true);
          }

      // Button lock hole
      translate([lock_to_pcb_left, 0, lock_support_height+2])
        cube([lock_hole_width, hole_depth, lock_ext_thickness+shim], true);

      translate([0, 2-radius, 0]) {
      // PPP button hole
        translate([center, center, thickness+shim])
          rotate([0, 0, 135])
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

      // Reset hole
      translate([47.75, 56.2, -height])
        cylinder($fn = 40, d = pinhole_diameter, h = height, center);

      // Charge LED hole
      translate([center + 3.75,  length - 3, -height])
        cylinder($fn = 40, d = pinhole_diameter, h = height, center);

      // Logo
      translate([width/4 + 2, length*3/4, 0])
        rotate([180,0,0])
          linear_extrude(height = text_depth, center = true)
            text("OSAB", size = 8, font="Stardos Stencil:style=Regular");
  }

  // Dimple mates
  translate([thickness - radius, length - height/4, height + radius - height/4 + dimple])
    rotate([90, 0, 0])
      cylinder($fn = 40, h = length - height/2, d = dimple);
  translate([width + radius - thickness, length - height/4, height + radius - height/4 + dimple])
    rotate([90, 0, 0])
      cylinder($fn = 40, h = length - height/2, d = dimple);

  // PCB mounts
  translate([mount_hole_offset, length - mount_hole_offset - 0.4, 0])
    pcb_mount(mount_base_height, mount_base_diameter, mount_nipple_height, mount_nipple_diameter);

  translate([width - mount_hole_offset, length - mount_hole_offset - 0.4, 0])
    pcb_mount(mount_base_height, mount_base_diameter, mount_nipple_height, mount_nipple_diameter);

  // PCB clips
  rotate([0, -90, -90])
    translate([thickness, -clip_thickness, 0.9*pcb_length-clip_width/2])
      clip();
  rotate([0, -90, -90])
    translate([thickness, -clip_thickness, 0.5*pcb_length-clip_width/2])
      clip();
  rotate([0, -90, -90])
    translate([thickness, -clip_thickness, 0.1*pcb_length-clip_width/2])
      clip();
  rotate([0, -90, 90])
    translate([thickness, -pcb_width-clip_thickness, -0.9*pcb_length-clip_width/2])
      clip();
  rotate([0, -90, 90])
    translate([thickness, -pcb_width-clip_thickness, -0.5*pcb_length-clip_width/2])
      clip();
  rotate([0, -90, 90])
    translate([thickness, -pcb_width-clip_thickness, -0.1*pcb_length-clip_width/2])
      clip();

  // Button lock support
  translate([lock_to_pcb_left, 0, thickness+lock_support_height/2])
    union() {
      cube([lock_support_width, lock_support_thickness, lock_support_height], true);
      translate([0, 0, lock_support_height/2])
        rotate([0, 90, 0])
          cylinder($fn=40, h=lock_support_width, d=lock_support_thickness, center=true);
  }
}
// end - Front shell


// begin - Back shell
translate([width, 0, 2.25*height])
  rotate([0,180,0])
    union() {
      difference() {
        shell(thickness = thickness, radius = radius, width = width, length = length, height = height/4);

        // Speaker holes
        translate([center, speaker_diameter/2 + radius, thickness+0.25]) {
          r = 3;
          for (Q = [0:60:300]) {
            translate([r*cos(Q), r*sin(Q), -speaker_hole_height])cylinder(h=speaker_hole_height, d=speaker_hole_diameter);
          }
          rad = 8;
          for (Q = [0:30:330]) {
            translate([rad*cos(Q), rad*sin(Q), -speaker_hole_height])
              cylinder(h=speaker_hole_height, d=speaker_hole_diameter);
            }
          for (r = [13:5:23]) {
            for (Q = [0:15:345]) {
              translate([r*cos(Q), r*sin(Q), -speaker_hole_height])cylinder(h=speaker_hole_height, d=speaker_hole_diameter);
            }
          }
        }
      }
      // Speaker fence
      translate([center, speaker_diameter/2 + radius, thickness])
        difference() {
          cylinder(h=1, d=speaker_diameter + 2 + 2*shim);
          translate([0, 0, -0.5])
            cylinder(h=2, d=speaker_diameter + 2*shim);
        }
      // Inside lip
      difference() {
        shell(thickness = thickness, radius = radius - thickness, width = width, length = length, height = 2*height/3);
        translate([-width/2, -length/2, 0])
        cube([2*width, 2*length, height/4]);
        // Dimples
        translate([-radius + thickness, length, height - dimple])
          rotate([90, 0, 0])
            cylinder($fn = 40, h = length, d = dimple);
        translate([width + radius - thickness, length, height - dimple])
          rotate([90, 0, 0])
            cylinder($fn = 40, h = length, d = dimple);
        // Cuts in lip
        translate([-width/2,  0, height*3/4 + shim])
          cube([2*width, height/4, height/4]);
        translate([-width/2, length -radius/2, height*3/4 + shim])
          cube([2*width, height/4, height/4]);
      }
      // Rounding the lip
      translate([-radius + thickness + 0.755, length - height/4, height])
        rotate([90, 0, 0])
          cylinder($fn = 40, h = length - height/2, d = thickness);
      translate([width + 2*thickness - 0.255, length - height/4, height])
        rotate([90, 0, 0])
          cylinder($fn = 40, h = length - height/2, d = thickness);
    }

// end - Back shell


// Buttons
translate([0, 2-radius, 0]) {
  difference() {
   union() {
    // PPP button
    /*color("red")*/
      translate([center, center, thickness])
        rotate([0, 0, 135])
            triangular_button(7, 2, button_height);

    // Chap+ button
    /*color("orange")*/
      translate([center+button_gap, center, thickness])
        square_button(5, 2, button_height);

    // Chap- button
    /*color("orange")*/
      translate([center-button_gap, center, thickness]) 
        square_button(5, 2, button_height);

    // Book- button
    /*color("brown")*/
      translate([center, center+button_gap, thickness])
        square_button(5, 2, button_height);

    // Book+ button
    /*color("brown")*/
      translate([center, center-button_gap, thickness])
        square_button(5, 2, button_height);

    // Category button
    /*color ("grey")*/
      translate([center+cat_button_x, center-cat_button_y, thickness])
        round_button(4, button_height);

    // Vol- button
    /*color("blue")*/
      translate([center-vol_button_x, center+vol_button_y, thickness])
        round_button(4, button_height);

    // Vol+ button
    /*color("blue")*/
      translate([center+vol_button_x, center+vol_button_y, thickness])
        round_button(4, button_height);

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
    // Play LED hole
    translate([center, center, 0 - height])
        rotate([0, 0, 135])
      cylinder($fn = 40, d = 1.5, h = height, center);
  }
}


// PCB
%translate([width/2, pcb_length/2-(radius-(thickness+shim)), clip_chin_height+pcb_thickness+thickness]) {
  rotate([0, 180, 180]) {
    import("osab.stl", convexity=10);
  }
}


// AA cells
*translate([width, 50, 0])
  rotate([0, 0, 90]) {
    translate([width/2, width/2, 20]) {
      rotate([90, 0, 0]) {
        color("orange")
          cylinder(h=49.5, d=14.5, center=true);
            translate([0, 0, 25.25])
              color("silver")
                cylinder(h=1, d=5.5, center=true);
      }
    }
    translate([width/2+15, width/2, 20]) {
      rotate([270, 0, 0]) {
        color("orange")
          cylinder(h=49.5, d=14.5, center=true);
            translate([0, 0, 25.25])
              color("silver")
                cylinder(h=1, d=5.5, center=true);
      }
    }
    translate([width/2-15, width/2, 20]) {
      rotate([270, 0, 0]) {
        color("orange")
          cylinder(h=49.5, d=14.5, center=true);
    translate([0, 0, 25.25])
      color("silver")
        cylinder(h=1, d=5.5, center=true);
      }
    }
  }

// Speaker
*translate([center, speaker_diameter/2 + radius, 6*height - thickness])
  rotate([180, 0, 0])
    {
      %color("grey") {
        cylinder(h=2.3, d=speaker_diameter);
        translate([0, 0, 2.3])
          cylinder(h=1.7, d=45.5);
        translate([0, 0, 4])
          cylinder(h=1, d=28.5);
        translate([0, 0, 5])
          cylinder(h=3, d=16.8);
      }
    }


// Button lock extension
translate([lock_to_pcb_left, 0, thickness+lock_support_thickness/2+lock_support_height])
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
