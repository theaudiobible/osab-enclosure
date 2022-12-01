/*
shell.scad - Main shell for the OSAB enclosure.

OSAB - the Open Source Audio Bible player.

Copyright (C) 2011-2022 Theophilus (http://theaudiobible.org)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/


use <shell-modules.scad>;
use <button-modules.scad>;
include <vars.scad>;

union() {
  difference() {
      shell(thickness = thickness, width = width, length = length, height = height);

      // Light hole
      translate([light_hole_x, -(pcb_thickness + light_height)/2, length/2])
        linear_extrude(height=hole_depth, center=true, convexity=10, twist=0, $fn=40, scale=2)
          circle(d=light_hole_diam);

      // Charge LED hole
      translate([charge_led_hole_x, -(pcb_thickness + charge_led_height)/2, length/2])
        linear_extrude(height=hole_depth, center=true, convexity=10, twist=0, $fn=40, scale=2)
          circle(d=charge_led_hole_diam);

      // Earphone socket hole
      translate([earhpone_hole_x, -(earphone_diam+pcb_thickness)/2, length/2])
        cylinder(h=hole_depth, d=earphone_diam, center=true);

      // USB-C socket hole
      w = usb_width - usb_corner_radius;
      translate([0, -(usb_height+pcb_thickness)/2, length/2])
          union() {
              cube([w, usb_height, hole_depth], center=true);
              cube([usb_width, usb_height-usb_corner_radius, hole_depth], center=true);
              translate([w/2, (usb_height-usb_corner_radius)/2, 0])
                cylinder($fn=40, h=hole_depth, d=usb_corner_radius, center=true);
              translate([-w/2, (usb_height-usb_corner_radius)/2, 0])
                cylinder($fn=40, h=hole_depth, d=usb_corner_radius, center=true);
              translate([w/2, -(usb_height-usb_corner_radius)/2, 0])
                cylinder($fn=40, h=hole_depth, d=usb_corner_radius, center=true);
              translate([-w/2, -(usb_height-usb_corner_radius)/2, 0])
                cylinder($fn=40, h=hole_depth, d=usb_corner_radius, center=true);
          }

      // Button lock hole
      translate([-lock_x_offset, -(lock_height + pcb_thickness)/2, length/2])
        cube([lock_hole_width, lock_shaft_height, hole_depth], true);

      rotate([-90, 0, 0])
      translate([-width/2, -length/3, -thickness-height/2]) {
      // PPP button cutter
        a = sqrt(3)/2*triangle_button_side;
        b = triangle_button_side/2 * tan(30);
        d = b - triangle_button_side/2;
        translate([center + d, center - ppp_offset_from_pcb_center, thickness+shim])
          triangular_button_cutter(triangle_button_side + 2*layer_height, triangle_button_radius, button_height+4*shim);

      // Chap+ button cutter
        translate([center+button_gap, center - ppp_offset_from_pcb_center, thickness+shim])
          square_button_cutter(square_button_side + 2*layer_height, square_button_radius, button_height+4*shim);

      // Chap- button cutter
        translate([center-button_gap, center - ppp_offset_from_pcb_center, thickness+shim])
          square_button_cutter(square_button_side + 2*layer_height, square_button_radius, button_height+4*shim);

      // Book- button cutter
        translate([center, center+button_gap - ppp_offset_from_pcb_center, thickness+shim])
          square_button_cutter(square_button_side + 2*layer_height, square_button_radius, button_height+4*shim);

      // Book+ button cutter
        translate([center, center-button_gap - ppp_offset_from_pcb_center, thickness+shim])
          square_button_cutter(square_button_side + 2*layer_height, square_button_radius, button_height+4*shim);

      // Category button cutter
        translate([center+cat_button_x, center-cat_button_y - ppp_offset_from_pcb_center, thickness+shim])
          round_button_cutter(cat_button_radius + 2*layer_height, button_height+4*shim);

      // Light button cutter
        translate([center-light_button_x, center-light_button_y - ppp_offset_from_pcb_center, thickness+shim])
          round_button_cutter(vol_button_radius + 2*layer_height, button_height+4*shim);

      // Vol- button cutter
        translate([center-vol_button_x, center+vol_button_y - ppp_offset_from_pcb_center, thickness+shim])
          round_button_cutter(vol_button_radius + 2*layer_height, button_height+4*shim);

      // Vol+ button cutter
        translate([center+vol_button_x, center+vol_button_y - ppp_offset_from_pcb_center, thickness+shim])
          round_button_cutter(vol_button_radius + 2*layer_height, button_height+4*shim);
      }

      // Speaker holes
      translate([0, 0, -(length+thickness)/4])
       rotate([90, 0, 0]) {
        r = speaker_ring_radius_inner;
        for (Q = [0:60:300]) {
          translate([r*cos(Q), r*sin(Q), -speaker_hole_height])cylinder(h=speaker_hole_height, d=speaker_hole_diameter, center=true);
        }
        rad = speaker_ring_radius_middle;
        for (Q = [0:20:340]) {
          translate([rad*cos(Q), rad*sin(Q), -speaker_hole_height])
            cylinder(h=speaker_hole_height, d=speaker_hole_diameter, center=true);
          }
        rd = speaker_ring_radius_outer;
        for (Q = [0:15:345]) {
          translate([rd*cos(Q), rd*sin(Q), -speaker_hole_height])cylinder(h=speaker_hole_height, d=speaker_hole_diameter, center=true);
        }
      }

      // Logo
      translate([-osab_x, -(height/2 + 1.1*thickness), -osab_z])
        rotate([90, 0, 0]) {
          linear_extrude(height = text_depth, center = true)
            text("OSAB", size = 8, font="Stardos Stencil:style=Regular");
          translate([-tab_x, -tab_y, 0])
            linear_extrude(height = text_depth, center = true)
              text("TheAudioBible.org", size = 3.2, font="Cantarell:style=Bold");
        }
  }

  rotate([-90, 0, 0])
  translate([-width/2, -length/3, -thickness*1.6-height/2]) {
    // PPP button support
      translate([center, center - ppp_offset_from_pcb_center, thickness+shim])
        triangular_button_support(triangle_button_side + layer_height, triangle_button_radius, layer_height, nozzle_diam);

    // Chap+ button support
      translate([center+button_gap, center - ppp_offset_from_pcb_center, thickness+shim])
        square_button_support(square_button_side + layer_height, square_button_radius, layer_height, nozzle_diam);

    // Chap- button support
      translate([center-button_gap, center - ppp_offset_from_pcb_center, thickness+shim])
        square_button_support(square_button_side + layer_height, square_button_radius, layer_height, nozzle_diam);

    // Book- button support
      translate([center, center+button_gap - ppp_offset_from_pcb_center, thickness+shim])
        square_button_support(square_button_side + layer_height, square_button_radius, layer_height, nozzle_diam);

    // Book+ button support
      translate([center, center-button_gap - ppp_offset_from_pcb_center, thickness+shim])
        square_button_support(square_button_side + layer_height, square_button_radius, layer_height, nozzle_diam);

    // Category button support
      translate([center+cat_button_x, center-cat_button_y - ppp_offset_from_pcb_center, thickness+shim])
        round_button_support(cat_button_radius + layer_height, layer_height, nozzle_diam);

    // Light button support
      translate([center-light_button_x, center-light_button_y - ppp_offset_from_pcb_center, thickness+shim])
        round_button_support(vol_button_radius + layer_height, layer_height, nozzle_diam);

    // Vol- button support
      translate([center-vol_button_x, center+vol_button_y - ppp_offset_from_pcb_center, thickness+shim])
        round_button_support(vol_button_radius + layer_height, layer_height, nozzle_diam);

    // Vol+ button support
      translate([center+vol_button_x, center+vol_button_y - ppp_offset_from_pcb_center, thickness+shim])
        round_button_support(vol_button_radius + layer_height, layer_height, nozzle_diam);
  }

  // Speaker retainer
  translate([0, (height - thickness)/2, -(length + thickness)/4])
    rotate([-90, 0, 180])
      speaker_retainer();

  // Anti-groove - left
  translate([(width/2 - groove_diam), anti_groove_dy, tongue_groove_height + groove_diam/2 + 2*thickness - length/2 + tongue_dy/2])
    rotate([90, 0, 0])
      groove(groove_diam, groove_width);
  // Anti-groove - right
  translate([-(width/2 - groove_diam), anti_groove_dy, tongue_groove_height + groove_diam/2 + 2*thickness - length/2 + tongue_dy/2])
    rotate([90, 0, 0])
      groove(groove_diam, groove_width);

  // Battery retainer
  translate([(battery_width + battery_retainer_wall_thickness)/2, (height - battery_thickness)/2, battery_length/2 + 5.235])
    battery_retainer("right");
  translate([-(battery_width + battery_retainer_wall_thickness)/2, (height - battery_thickness)/2, battery_length/2 + 5.235])
    battery_retainer("left");

}
