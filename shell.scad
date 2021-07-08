/*
osab-enclosure.scad - the OSAB enclosure.

OSAB - the Open Source Audio Bible player.

Copyright (C) 2011-2021 Theophilus (http://theaudiobible.org)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

use <shell-modules.scad>;
include <vars.scad>;

union() {
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
    translate([(width-height-thickness/2)/2, thickness-height/2, 8-length/2])
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

  // Groove mates
  groove(groove_diam);
}
