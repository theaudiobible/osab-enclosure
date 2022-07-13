/*
vars.scad - Variables for the OSAB enclosure.

OSAB - the Open Source Audio Bible player.

Copyright (C) 2011-2022 Theophilus (http://theaudiobible.org)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/


$fa=0.5; // default minimum facet angle is now 0.5
$fs=0.5; // default minimum facet size is now 0.5 mm

nozzle_diam = 0.35; // 3D printer nozzle diameter

thickness = 2;
pcb_width = 50;
pcb_edge_clearance = 1.5;
ppp_offset_from_pcb_center = 2.5;
height = 13;
width = pcb_width + nozzle_diam;
length = width*(1+sqrt(5))/2;
pcb_length = length - 3*thickness;
pcb_thickness = 1.0;
hole_depth = 8*thickness;
shim = 0.2;  // Set to layer height
radius = 5;
center = width/2;
dimple = 1.2;
speaker_top_diam = 16;
speaker_mid_diam = 28.0;
speaker_bot_diam = 30.5;
speaker_top_ht = 1.5;
speaker_mid_ht = 1.1;
speaker_bot_ht = 2.4;
speaker_hole_diameter = 2;
speaker_hole_height = 4*thickness;
cat_button_x = 15;
cat_button_y = 17;
light_button_x = 9.85;
light_button_y = 26.5;
vol_button_x = 15;
vol_button_y = 17;
switch_height = 1.5;
triangle_button_side = 6;
triangle_button_radius = 2;
square_button_side = 5;
square_button_radius = 2;
cat_button_radius = 4;
vol_button_radius = 3;
light_button_radius = 2;
//button_height = 9 - 2*switch_height - shim;
button_height = 4;
button_gap = 14;
strip_width = 3;
strip_height = 1;
earphone_diam = 5 + 2*shim;
earphone_height = 2.3;
earphone_to_pcb_right = 19.25;
usb_width = 9;
usb_height = 3.2;
pinhole_diameter = 1.2;
lock_hole_width = 4.2;
lock_lever_altitude = 0.4;
lock_lever_depth = 1.5;
lock_lever_width = 1.3;
lock_ext_depth = 4;
lock_ext_thickness = (height - pcb_thickness)/2;
lock_ext_width = 7;
lock_ext_lever_width = 2;
lock_ext_lever_length = 4;
lock_support_width = 15;
lock_support_thickness = 1;
lock_support_height = height/2 - pcb_thickness/2 - lock_ext_thickness/2;
text_depth = 1;
holder_width = 15.35;
holder_length = 14.5;
holder_height = 2.45;
card_width = 11.05;
card_length = 2.65;
card_height = 1.00;
tongue_length = 20;
tongue_width = 4;
tongue_thickness = 4;
tongue_hole_diam = 2;
groove_diam = 1.5;
groove_width = 1.1*tongue_width;
