/*
osab-enclosure.scad - the OSAB enclosure.

OSAB - the Open Source Audio Bible player.

Copyright (C) 2011-2022 Theophilus (http://theaudiobible.org)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/


include <vars.scad>;


rotate([-90, 0, 0])
translate([width*3/10, lock_ext_depth-length/2, -(lock_ext_thickness+pcb_thickness)/2])
  difference() {
    union() {
      cube([lock_ext_width, lock_ext_depth, lock_ext_thickness], true);
      translate([0, -radius/sqrt(2), 0])
        minkowski() {
          cube([lock_ext_lever_width, lock_ext_lever_length, lock_ext_thickness/1.25], true);
          cylinder(h=1, d=1, center=true);
        }
    }
    translate([0, (lock_ext_depth-lock_lever_depth)/2, 0])
      cube([lock_lever_width+shim, lock_lever_depth+shim, lock_ext_thickness+shim], true);
}
