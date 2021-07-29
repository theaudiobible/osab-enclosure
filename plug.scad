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

difference() {
  union() {
    // Shell insert
    translate([0, 0, thickness-length/2])
      difference() {
        outershell(width, 2*thickness, height);
        translate([0, 0, -thickness])
          outershell(width-2*thickness, 2*thickness, height-2*thickness);
      }
    // Speaker retainer
    translate([0, (height-thickness)/2, -(length+thickness)/4])
      rotate([90, 0, 0])
        difference() {
          speaker_retainer();
          translate([0, thickness-2*height, 0])
            cube([width, height, height], center=true);
        }
    // Tongue
    translate([0, (tongue_thickness-height)/2, (tongue_length-length)/2]) {
      cube([tongue_width, tongue_thickness, tongue_length], center=true);
      translate([0 ,0 ,(tongue_length)/2])
        rotate([0, 90, 0])
          cylinder($fn=40, h=tongue_width, d=tongue_thickness, center=true);
    }
  }
  // Card slot
  translate([-20.2, (holder_height-card_height-height/2)/2, 1.2-length/2])
    cube([card_width*1.1, card_height*1.1, card_length*1.1]);
  // Button lock hole
  translate([(width-height)/2-2.1, pcb_thickness-lock_ext_thickness, -length/2])
    cube([lock_hole_width, lock_ext_thickness, hole_depth], true);
  // Tongue cavity
  translate([0, (tongue_thickness-height)/2, (tongue_length-length-thickness)/2])
    cube([tongue_width-thickness, tongue_thickness-thickness, tongue_length], center=true);
  // Groove
  groove(1.1*groove_diam, groove_width);
}
