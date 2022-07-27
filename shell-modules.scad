/*
shell-modules.scad - Shell modules for the OSAB enclosure.

OSAB - the Open Source Audio Bible player.

Copyright (C) 2011-2022 Theophilus (http://theaudiobible.org)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/


include <vars.scad>;


// Outershell
module outershell(width, length, height) {
  union() {
    cube([width-height, height, length], center=true);
    translate([(width-height)/2, 0, 0])
      cylinder(h = length, d = height, center=true);
    translate([-(width-height)/2, 0, 0])
      cylinder(h = length, d = height, center=true);
  }
}


// Shell
// width, length, height for inner dims
module shell(width, length, height, thickness) {
  union() {
    difference() {
      outershell(width+2*thickness, length, height+2*thickness);
      outershell(width, length+shim, height);
    }
    // PCB support
    difference() {
      union() {
        translate([(width-height)/2, 0, thickness/2])
          cylinder(h = length-3*thickness, d = height, center=true);
        translate([-(width-height)/2, 0, thickness/2])
          cylinder(h = length-3*thickness, d = height, center=true);
      }
      cube([(width-2*pcb_edge_clearance), height, length+shim], center=true);
      difference() {
        outershell(width, length+shim, height);
        translate([0, height/4, 0])
          cube([width*2, height/2-pcb_thickness-2*shim, length+shim], center=true);
        translate([0, -height/4, 0])
          cube([width*2, height/2-pcb_thickness-2*shim, length+shim], center=true);
      }
    }
    translate([0, 0, (length - thickness)/2])
      outershell(width+thickness/2, thickness, height+thickness);
  }
}


// Speaker retainer
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
  ht = 1.8*speaker_bot_ht;
  translate([0, 0, -1])
  rotate_extrude(angle=-180, convexity=10)
  translate([(speaker_bot_diam+2*thickness)/2, 0, 0])
  polygon([[0, 0], [ht, 0], [0, ht]]);
}


// Plug grooves
module groove(diam, width) {
  translate([0, -height/2, -1.05*tongue_length])
    rotate([0, 90, 0])
    cylinder($fn=40, h=width, d=diam, center=true);
}


// Tongue
module tongue(width, thickness, length) {
  difference() {
    union() {
      cylinder($fn=40, h=length, d=thickness, center=true);
      translate([0 ,0, length/2])
        rotate([0, 90, 0])
          sphere(d=thickness);
    }
    translate([0, 0, length/2-(thickness-tongue_hole_diam)/2])
      rotate([0, 90, 0])
        sphere(d=tongue_hole_diam);
  // Groove
  translate([0, (height-thickness)/2, length+length/2])
    groove(1.1*groove_diam, groove_width);
  }
  // Tongue cavity
  translate([0, 0, 0])
    cylinder($fn=40, h=tongue_length, d=tongue_hole_diam, center=true);

}
