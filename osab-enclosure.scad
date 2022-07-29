/*
osab-enclosure.scad - the entire OSAB enclosure.

OSAB - the Open Source Audio Bible player.

Copyright (C) 2011-2022 Theophilus (http://theaudiobible.org)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/


//include <vars.scad>;
include <shell.scad>;
include <buttons.scad>;
include <plug.scad>;


// PCB
translate([0, 0, ppp_offset_from_pcb_center/2]) {
  rotate([90, 0, 0]) {
    import("osab.stl", convexity=10);
  }
}


// simPCB
//color("green")
//  translate([0, 0, thickness/2])
//    rotate([90, 0, 0])
//      cube([width, pcb_length, pcb_thickness], center=true);


// simLithiumBattery
//color("grey")
//  translate([0, height/4, length/5])
//    cube([38, 6, 25], center=true);


// simCardHolder
//translate([(height-width)/3, -holder_height/2, card_length/2-length/2.65]) {
//  rotate([90, 180, 0]) {
//    color("grey")
//      cube([holder_width, holder_length, holder_height], center=true);
//      color("red")
//        translate([1.5, holder_length/2, card_height/2])
//          cube([card_width, card_length, card_height], center=true);
//  }
//}


// simSpeaker
//translate([0, (height-thickness)/2, -(length+thickness)/4])
//  rotate([90, 0, 0])
//    {
//      %color("grey") {
//        cylinder(h=speaker_bot_ht, d=speaker_bot_diam, center=true);
//        translate([0, 0, (speaker_bot_ht+speaker_mid_ht)/2])
//          cylinder(h=speaker_mid_ht, d=speaker_mid_diam, center=true);
//        translate([0, 0, (speaker_bot_ht+speaker_mid_ht+speaker_top_ht)/2])
//          cylinder(h=speaker_top_ht, d=speaker_top_diam, center=true);
//      }
//    }
