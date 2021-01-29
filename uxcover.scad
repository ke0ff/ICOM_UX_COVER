// OpenSCAD 2019.05
// UXFFront Unit cover, REV-003
// Joe Haas, KE0FF, 01/13/2021
// This is a decent approximation of the ICOM UX module front cover piece.  It has an added hole
//	for a DB-9 connector to mate with the UX-FFront unit in Stand-Alone RX mode.  To remove the
//	DB-9 artifacts, comment-out the section identified as "DB-9 Artifacts".
// The "LED Opening" is modeled as a round hole to accept a light pipe for an SMD LED (as implemented
//	on the FFront unit PCB).  To match the original ICOM format, a rectangular hole is needed.
//	comment out the light-pipe section and then un-comment the rectangular hole section to generate
//	the original ICOM opening.
//
// Rev-004, 01/29/2021
// Added user-defined parameters ("light_pipe", "place_db9", and "delta_h").  These parameters allow for
//	quick modifications to some common options.  For a "standard" cover, set the parameters as follows:
//		light_pipe = 0;
//		place_db9 = 0;
//		delta_h = 0;
//
// Comment cleanup.
//
// Fixed detent#2 placement.

use <char.scad>

//----------------------------------------------------------------------------------------------------------------------
// User defined parameters.  Modify these to suit a particular application
// NOTE: All data in this file is in mm

light_pipe = 0;						// zero places standard rectangular LED hole, non-zero places light-pipe opening
place_db9 = 0;						// non-zero to place the DB-9 cut-out
delta_h = 0;						// stretch height parameter.  Use this to make a deeper cover for UXFF applications

//----------------------------------------------------------------------------------------------------------------------
// parametric variables:
shroud_height = 26.2 + delta_h;
main_height = shroud_height - 12;

difference(){
	union(){
	  difference(){
		union(){
		  translate([0,0,4]) cube([176.5,25,main_height]);				// bottom section of main body
		  translate([1.07,1.07,0]) cube([173.8,23,shroud_height]);		// top section (the shroud)
		  translate([126,1.07,0]) cube([27,23,10]);						// cable break section
		}
		translate([2.5,2.85,4]) cube([171.5,19.5,42.26]);				// main central void
		translate([126.7,-1,18.21+delta_h]) cube([29.5,30,30]);			// cable break void
		translate([0,5.40,18.541+delta_h]) cube([177.8,14.22,8]);		// void at the ends of the shroud
	// DB-9 Artifacts -->
		if(place_db9){
			translate([79.68,8.1,-1]) cube([18.44,10.06,10]);			// DB9 cutout
			translate([72.9,6.19,2.3]) cube([32,14,4.1]);				// DB9 CM
			translate([76.20,13.19,-1]) cylinder(r=1.6, h=10, $fn=16);	// db9 holes, #1
			translate([101.60,13.19,-1]) cylinder(r=1.6, h=10, $fn=16);	//		#2
		}
	// --> End of DB-9 artifacts
	  }
	  translate([-1.02,7.43,12.45+delta_h]) cube([2.3,10.16,12.95]);	// end tab
	  translate([174.9,7.43,12.45+delta_h]) cube([2.3,10.16,12.95]);	// end tab
	  translate([59.06,0,3.9]) cube([1.52,24.51,7.1]);					// re-enforcing rib #1
	  translate([117.22,0,3.9]) cube([1.52,24.51,9.1]);					// re-enforcing rib #2
	  translate([153,12.99,2]) cube([10,10,11.19]);						// light-pipe support
	  rotate([90,0,0]){
		translate([1.27,22.3+delta_h,-12.51]) cylinder(r=1.27, h=10.16, $fn=16, center = true);		// end tab detent #1
	  }
	  rotate([90,0,0]){
		translate([175,22.3+delta_h,-12.51]) cylinder(r=1.27, h=10.16, $fn=16, center = true);		// end tab detent #2
	  }
	  translate([2.5,2.75,4]) cube([171.5,2,1.5]);						// corner reinforce (bot)
	  translate([2.5,20.6,4]) cube([171.5,2.1,1.5]);					// corner reinforce (top)
	  translate([2.5,2.75,4]) cube([2,20.6,1.5]);						// corner reinforce (rs)
	  translate([172.1,2.75,4]) cube([2,20.6,1.5]);						// corner reinforce (ls)
	}
	union(){
		if(light_pipe){
			// Light-pipe hole -->
			translate([157.9,16.3,14]) cylinder(r=1.76, h=30, $fn=16, center = true);		// light pipe hole
			translate([157.9,16.3,-.10]) cylinder(r=2.73, h=1.75, $fn=16, center = true);	// light pipe countersink
			// --> End of light-pipe hole
		}else{
			// rectangular LED hole -->
			translate([157.9,16.3,14]) cube([11,10,25.4], center = true);		// LED "pan"
			translate([157.9,16.3,14]) cube([4.2,2.3,30], center = true);		// LED "hole"
			// --> End of rectangular LED hole
		}
	}
	translate([82,19.1,22.5+delta_h]) cube([13,4,5]);					// center tab clearance 1
	translate([82,2,22.5+delta_h]) cube([13,4,5]);						// center tab clearance 2
	translate([139.2,7,-.1]) cube([1.2,20,1.7]);						// decorative slot 1
	translate([0,7,-.1])   cube([140.1,1.2,1.7]);						// decorative slot 2
	translate([139.2,22.8,-.1]) cube([1.2,1.7,4]);						// decorative slot 3
	translate([.99,7,-.1])   cube([1.2,1.2,4]);							// decorative slot 4
	translate([-1,25.25,-4.1]) rotate([45,0,0]) cube([141.1,4,5]);		// decorative chamfer
	translate([30,9,.29]) rotate([180,0,90]) union(){
		char_CIRCLEI();
		translate([0,-4.6,0]) char_C();
		translate([0,-10,0]) char_O();
		translate([0,-17,0]) char_M();
	}

//  translate([-10,-10,-10]) cube([50,50,50]);					// section cut (leave commented-out unless needed for debug)
}
