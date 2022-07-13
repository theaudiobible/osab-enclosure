/*
buttons.scad - Buttons for the OSAB enclosure.

OSAB - the Open Source Audio Bible player.

Copyright (C) 2011-2022 Theophilus (http://theaudiobible.org)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

use <button-modules.scad>;
include <vars.scad>;

pppoff = ppp_offset_from_pcb_center;

rotate([-90, 0, 0])
translate([-width/2, -length/3, -thickness-height/2]) {
    // PPP button
    color("red")
      translate([center, center - pppoff, thickness])
            triangular_button(6, 2, button_height);

    // Chap+ button
    color("orange")
      translate([center+button_gap, center - pppoff, thickness])
        square_button(5, 2, button_height);

    // Chap- button
    color("orange")
      translate([center-button_gap, center - pppoff, thickness])
        square_button(5, 2, button_height);

    // Book- button
    color("brown")
      translate([center, center+button_gap - pppoff, thickness])
        square_button(5, 2, button_height);

    // Book+ button
    color("brown")
      translate([center, center-button_gap - pppoff, thickness])
        square_button(5, 2, button_height);

    // Category button
    color ("grey")
      translate([center+cat_button_x, center-cat_button_y - pppoff, thickness])
        round_button(4, button_height);

    // Vol- button
    color("blue")
      translate([center-vol_button_x, center+vol_button_y - pppoff, thickness])
        round_button(4, button_height);

    // Vol+ button
    color("blue")
      translate([center+vol_button_x, center+vol_button_y - pppoff, thickness])
        round_button(4, button_height);

    translate([0, 0, button_height-strip_height/2]) {
      strip(center, center - pppoff, center+vol_button_x, center+vol_button_y - pppoff, strip_width, strip_height);

      strip(center, center - pppoff, center-vol_button_x, center+vol_button_y - pppoff, strip_width, strip_height);

      strip(center, center - pppoff, center+cat_button_x, center-cat_button_y - pppoff, strip_width, strip_height);

      strip(center, center+button_gap - pppoff, center+vol_button_x, center+vol_button_y - pppoff, strip_width, strip_height);

      strip(center, center+button_gap - pppoff, center-vol_button_x, center+vol_button_y - pppoff, strip_width, strip_height);

      strip(center+button_gap, center - pppoff, center+vol_button_x, center+vol_button_y - pppoff, strip_width, strip_height);

      strip(center+button_gap, center - pppoff, center+cat_button_x, center-cat_button_y - pppoff, strip_width, strip_height);

      strip(center-vol_button_x, center+vol_button_y - pppoff, center-button_gap, center - pppoff, strip_width, strip_height);

      strip(center-button_gap, center - pppoff, center, center-button_gap - pppoff, strip_width, strip_height);
    }
}
