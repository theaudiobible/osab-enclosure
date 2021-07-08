/*
osab-enclosure.scad - the OSAB enclosure.

OSAB - the Open Source Audio Bible player.

Copyright (C) 2011-2021 Theophilus (http://theaudiobible.org)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/


include <vars.scad>;


rotate([90, 0, 180])
translate([1-(width-height)/2, lock_ext_depth-length/2, pcb_thickness-lock_ext_thickness])
  difference() {
    union() {
      cube([lock_ext_width, lock_ext_depth, lock_ext_thickness], true);
      translate([0, -radius/sqrt(2), 0])
        minkowski() {
          cube([1, 8, lock_ext_thickness/2], true);
          cylinder(h=1, d=1, center=true);
        }
    }
    translate([0, (lock_ext_depth-lock_lever_depth)/2, 0])
      cube([lock_lever_width+shim, lock_lever_depth+shim, lock_ext_thickness+shim], true);
    translate([0, 0, -lock_ext_thickness/4])
      cube([lock_support_width, lock_support_thickness+shim, lock_ext_thickness/2+shim], true);
}
