/*
plug.scad - Base plug for the OSAB enclosure.

OSAB - the Open Source Audio Bible player.

Copyright (C) 2011-2022 Theophilus (http://theaudiobible.org)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

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
        //translate([0, 0, -thickness])
        //  outershell(width-2*thickness, 2*thickness, height-2*thickness);
      }
    // Speaker retainer
    translate([0, (height-thickness)/2, -(length+thickness)/4])
      rotate([90, 0, 0])
        difference() {
          speaker_retainer();
          translate([0, thickness-2*height, 0])
            cube([width, height, height], center=true);
        }
    // Tongue - left
    translate([tongue_dx+thickness-width/2, tongue_dy+thickness, (tongue_length-length)/2])
      rotate([0, 0, -90])
        tongue(tongue_width, tongue_length);
    // Tongue - right
    translate([-tongue_dx-thickness+width/2, tongue_dy+thickness, (tongue_length-length)/2])
      rotate([0, 0, 90])
        tongue(tongue_width, tongue_length);
  }
  // Tongue cavity (to break through 'Shell insert' above) - left
  translate([tongue_dx+thickness-width/2, tongue_dy+thickness, (tongue_length-length)/2 - shim])
    cylinder($fn=40, h=tongue_length, d=tongue_hole_diam, center=true);
  // Tongue cavity (to break through 'Shell insert' above) - right
  translate([-tongue_dx-thickness+width/2, tongue_dy+thickness, (tongue_length-length)/2 - shim])
    cylinder($fn=40, h=tongue_length, d=tongue_hole_diam, center=true);

  // PCB cutout
  rotate([90, 0, 0])
    translate([0, 0.8, 0])
      cube([width, pcb_length, pcb_thickness*1.1], center=true);

  // Card slot
  //translate([-(card_x_offset + 5.7), (holder_height-card_height-height/2)/2, 1.2-length/2])
  //  cube([card_width*1.2, card_height*1.2, card_length*2]);
}
