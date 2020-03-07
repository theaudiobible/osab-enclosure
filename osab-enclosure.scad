/*
osab-1.0.scad - the OSAB enclosure.

OSAB - the Open Source Audio Bible player.

Copyright (C) 2011-2017 Theophilus (http://audiobibleplayer.org)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FI
*/

// begin shell
module shell(width, height, radius, thickness) {
	difference() {
		minkowski() {
			cube([width,depth,height]);


			difference() {
				translate([0,0,radius])
					sphere(radius);
				translate([-radius,-radius,radius])
					cube(2*radius);
			}
		}

		minkowski() {
			cube([width,depth,height+thickness]);

			difference() {
				translate([0,0,radius])
					sphere(radius-thickness);
				translate([-radius,-radius,radius])
					cube(2*radius);
			}
		}
	}
}
// end shell

// begin triangular_button
module triangular_button(side_length, corner_radius) {
	linear_extrude(height=5, center=true, convexivity=10, twist=0)
		hull() {
			circle(corner_radius);
			translate([side_length,side_length/4,0]) circle(corner_radius);
			translate([side_length/4,side_length,0]) circle(corner_radius);
		}
}
// end triangular_button


// begin square button
module square_button(side_length, corner_radius) {
	linear_extrude(height=5, center=true, convexivity=10, twist=0)
		hull() {
			translate([-side_length/2,-side_length/2,0]) circle(corner_radius);
			translate([side_length/2,-side_length/2,0]) circle(corner_radius);
			translate([side_length/2,side_length/2,0]) circle(corner_radius);
			translate([-side_length/2,side_length/2,0]) circle(corner_radius);
		}}
// end square button

// begin rectangular button
module rect_button(length, width, corner_radius) {
	linear_extrude(height=5, center=true, convexivity=10, twist=0)
		hull() {
			translate([-length/2,-width/2,0]) circle(corner_radius);
			translate([length/2,-width/2,0]) circle(corner_radius);
			translate([length/2,width/2,0]) circle(corner_radius);
			translate([-length/2,width/2,0]) circle(corner_radius);
		}}
// end rectangular button


// begin PCB support clip
module clip(height=10,width=clip_width,foot_thickness=foot_thickness,chin_height=6,chin_thickness=3,pcb_thickness=pcb_thickness) {
linear_extrude(height = width)
polygon(points = [[0,0],[height,0],[height,foot_thickness],[height-2,chin_thickness-0.5],[chin_height+pcb_thickness,chin_thickness-0.5],[chin_height+pcb_thickness,foot_thickness],[chin_height,foot_thickness],[chin_height,chin_thickness],[chin_height-1,chin_thickness],[chin_height-2,foot_thickness],[1,foot_thickness],[0,3],[0,foot_thickness]]);
}
// end clip



$fa=0.5; // default minimum facet angle is now 0.5
$fs=0.5; // default minimum facet size is now 0.5 mm


thickness = 1.5;
radius = 5;
width = 60;
depth = width*(1+sqrt(5))/2;
height = 10;
pcb_depth = 50;
pcb_shift = 2.5;
center = width/2;
offset = 4;
gap = 15;
clip_width = 5;
foot_thickness = 2;
pcb_thickness = 1.6;
shd = 2;                    // Speaker hole diameter
shh = thickness+0.5;        // Speaker hole height

%difference(){
    shell(thickness = thickness, radius = radius, width = width, height = height);
    // Speaker holes
    translate([center,depth-25,thickness+0.25]) {
        r = 3;
        for (Q = [0:60:300]) {
            translate([r*cos(Q),r*sin(Q),-shh])cylinder(h=shh,d=shd);
        }
        rad = 8;
        for (Q = [0:30:330]) {
            translate([rad*cos(Q),rad*sin(Q),-shh])cylinder(h=shh,d=shd);
        }
        for (r = [13:5:23]) {
            for (Q = [0:15:345]) {
                translate([r*cos(Q),r*sin(Q),-shh])cylinder(h=shh,d=shd);
            }
        }
    }
    translate([10,3,11.5]) rotate([0,0,180])
    translate([0,7,0]) rotate([90,0,0])
    cylinder(h=3,d=5.5,center=true);
}

translate([0,-4,0]) {
    // Category button
    color ("grey") translate([center+gap+offset,center-gap-offset,thickness]) cylinder(r=4, h=5, center=true);
    // PPP button
    color("red") translate([center+3,center,thickness]) rotate([0,0,135]) triangular_button(6, 2);
    // Chap- button
    color("orange") translate([center+gap,center,thickness]) square_button(5, 2);
    // Chap+ button
    color("orange") translate([center-gap,center,thickness]) square_button(5, 2);
    // Book+ button
    color("brown") translate([center,center+gap,thickness]) square_button(5, 2);
    // Book- button
    color("brown") translate([center,center-gap,thickness]) square_button(5, 2);
}


// Button lock
color("blue") translate([-2,15,5]) rotate([90,0,90])
hull() {
	cylinder(r=2, h=7, center=true);
	translate([5,0,0]) cylinder(r=2, h=7, center=true);
}
// Vol- button
color("blue") translate([-2,27.5,5]) rotate([90,0,90])
hull() {
	cylinder(r=2, h=7, center=true);
	translate([5,0,0]) cylinder(r=2, h=7, center=true);
}
// Vol+ button
color("purple") translate([-2,40,5]) rotate([90,0,90])
hull() {
	cylinder(r=2, h=7, center=true);
	translate([5,0,0]) cylinder(r=2, h=7, center=true);
}

// PCB
color("green") translate([0,-pcb_shift,6+thickness]) cube([width, width, pcb_thickness]);

// PCB clips
rotate([0,-90,180]) translate([thickness,-width-foot_thickness+pcb_shift,0.1*width-clip_width]) clip();
rotate([0,-90,180]) translate([thickness,-width-foot_thickness+pcb_shift,0.9*width]) clip();
rotate([0,-90,-90]) translate([thickness,-foot_thickness,0.9*width-clip_width]) clip();
rotate([0,-90,-90]) translate([thickness,-foot_thickness,0.1*width]) clip();
rotate([0,-90,90]) translate([thickness,-width-foot_thickness,-0.1*width-clip_width]) clip();
rotate([0,-90,90]) translate([thickness,-width-foot_thickness,-0.9*width]) clip();


// AA cells
translate([width,50,0]) rotate([0,0,90]) {
translate([width/2,width/2,20]) {
rotate([90,0,0]) {
color("orange")cylinder(h=49.5,d=14.5,center=true);
translate([0,0,25.25]) color("silver")cylinder(h=1,d=5.5,center=true);} }
translate([width/2+15,width/2,20]) {
rotate([270,0,0]) {
color("orange")cylinder(h=49.5,d=14.5,center=true);
translate([0,0,25.25]) color("silver")cylinder(h=1,d=5.5,center=true);} }
translate([width/2-15,width/2,20]) {
rotate([270,0,0]) {
color("orange")cylinder(h=49.5,d=14.5,center=true);
translate([0,0,25.25]) color("silver")cylinder(h=1,d=5.5,center=true);} }
}

// Speaker
translate([center,depth-25,thickness]) {
   %color("grey") {
        cylinder(h=2.3,d=50);
        translate([0,0,2.3])cylinder(h=1.7,d=45.5);
        translate([0,0,4])cylinder(h=1,d=28.5);
        translate([0,0,5])cylinder(h=3,d=16.8);
    }
    difference() {
        cylinder(h=1,d=53);
        translate([0,0,-0.5])cylinder(h=2,d=51);
    }
}

// Headphone Socket
translate([10,3,11.5]) rotate([0,0,180])
color("black") {
    cube([6.4,12,4.5],center=true);
    translate([0,7,0]) rotate([90,0,0]) difference() {
        cylinder(h=2,d=5,center=true);
        cylinder(h=2.1,d=3.6,center=true);
    }

    translate([0,3.6,-2.6]) cylinder(h=3,d=1.2,center=true);
    translate([0,-3.4,-2.6]) cylinder(h=3,d=1.2,center=true);
}

