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
// Rev-007, 02/02/2021
// Added "slope" to the main body.
//
// Rev-006, 02/01/2021
// Parameterized much of the model and used "rulers" to confirm dimensions.
// Added rounded and chamfered corners and inside re-inforcing structures.
// Added signature and dash# to inside face of part (dash# = delta_h rounded down to nearest mm).
// Added "+" to char.scad and modified circleI to better fit the part, parameterized chr depth.
//
// Rev-005, 01/31/2021
// Added delta_h to re-enforcing ribs.
//
// Rev-004, 01/29/2021
// Added user-defined parameters ("light_pipe", "place_db9", and "delta_h").  These parameters allow for
//	quick modifications to some common options.  For a "standard" cover, set the parameters as follows:
//		light_pipe = 0;
//		place_db9 = 0;
//		delta_h = 0;
//
// Comment cleanup.

use <char.scad>

//----------------------------------------------------------------------------------------------------------------------
// User defined parameters.  Modify these to suit a particular application
// NOTE: All data in this file is in mm

light_pipe = 0;						// zero places standard rectangular LED hole, non-zero places light-pipe opening
place_db9 = 1;						// non-zero to place the DB-9 cut-out
delta_h = 6;						// stretch height parameter.  Use this to make a deeper cover for UXFF applications

//----------------------------------------------------------------------------------------------------------------------
// parametric variables:
shroud_height = 26.2 + delta_h;
main_height = 14.05 + delta_h;
main_length = 176.5+.58;
main_width = 24.97;
main_twidth = 24.0;
mvoid_length = 172.21;
mvoid_width = 19.74;
slope = 1.4;
slope2 = 1.6;

shroud_length = 173.74;
shroud_width = 22.68;
face_length = 172.72;
face_width = 20.93;
face_thick = 4;
face_offsx = (main_length - face_length)/2; //2.54;
face_offsy = (main_width - face_width)/2; //2.54;
shroud_offsx = (main_length-shroud_length)/2; //1.65;
shroud_offsy = (main_width-shroud_width)/2; //1.27;
smchamrad = .985;
chamrad = 1.97;
chamrad2 = 1.97 - .4;
trim = 0.41;
foffsx = face_offsx+smchamrad;
foffsy = face_offsy+smchamrad;

// X-rulers
//#translate([-.69,0,0]) cube([0.01,30,50]);	// ruler
//#translate([175.41,0,0]) cube([0.01,30,50]);	// inside main void ruler 1
//#translate([1.67,0,0]) cube([0.01,30,50]);	// inside main void ruler 2
//#translate([175.34,0,0]) cube([0.01,30,50]);	// outside shroud ruler 2
// Y-rulers
//#translate([0,23.81,0]) cube([180,0.01,50]);	// ruler
//#translate([0,22.36 ,0]) cube([180,0.01,50]);	// ruler
// Z-rulers
//#translate([0,0,0]) cube([10,40,.01]);	// ruler
//#translate([0,0,2.04]) cube([9,40,.01]);	// ruler

difference(){
	union(){
	  difference(){
		union(){
		  // face
		  translate([face_offsx,face_offsy,0]) cube([face_length,face_width,face_thick+.1]);
		  // main body
		  translate([0,0,face_thick]) cube([main_length,main_width,main_height]);
		  // shroud
		  translate([shroud_offsx,shroud_offsy,face_thick]) cube([shroud_length,shroud_width,shroud_height-face_thick]);
		}
		// main central void
		translate([(main_length-mvoid_length)/2,(main_width-mvoid_width)/2,face_thick]) cube([mvoid_length,mvoid_width,42.26]);
		// cable break void
		translate([126.7,-1,18.21+delta_h]) cube([29.5,30,30]);
		// void at the ends of the shroud (creates the opening for the end-shroud)
		translate([0,5.40,18.541+delta_h]) cube([177.8,14.22,8]);
		// DB-9 Artifacts -->
		if(place_db9){
			translate([79.68,8.1,-1]) cube([18.44,10.06,10]);				// DB9 cutout
			translate([72.9,6.19,2.3]) cube([32,14,4.1]);					// DB9 CM
			translate([76.20,13.19,-1]) cylinder(r=1.6, h=10, $fn=16);		// db9 holes,	#1
			translate([101.60,13.19,-1]) cylinder(r=1.6, h=10, $fn=16);		//				#2
		}
		// <-- End of DB-9 artifacts
		// corner#1 chamfers
	    translate([face_offsx,face_offsy,1.95]) rotate([0,0,45]) cube([1.5,3.4,4.1], center = true);
	    translate([0,0,(29.1+delta_h)/2]) rotate([0,0,45]) cube([3,3.4,30+delta_h], center = true);
	    translate([shroud_offsx,shroud_offsy,((shroud_height + main_height)+4)/2]) rotate([0,0,45]) cube([1.5,3,shroud_height - main_height - 3.99], center = true);
		// corner#2 chamfers
	    translate([face_length+face_offsx,face_offsy,1.95]) rotate([0,0,45]) cube([1.7,3,4.1], center = true);
	    translate([main_length,0,(29.1+delta_h)/2]) rotate([0,0,-45]) cube([3,3.4,30+delta_h], center = true);
	    translate([shroud_length+shroud_offsx,shroud_offsy,((shroud_height + main_height)+4)/2]) rotate([0,0,45]) cube([3,1.5,shroud_height - main_height - 3.99], center = true);
		// corner#3 chamfers
	    translate([face_length+face_offsx,face_width+face_offsy,1.95]) rotate([0,0,45]) cube([1.5,3.4,4.1], center = true);
	    translate([main_length,main_width,(29.1+delta_h)/2]) rotate([0,0,-45]) cube([3.4,3,30+delta_h], center = true);
	    translate([shroud_length+shroud_offsx,shroud_width+shroud_offsy,((shroud_height + main_height)+4)/2]) rotate([0,0,45]) cube([1.5,3,shroud_height - main_height - 3.99], center = true);
		// corner#4 chamfers
	    translate([face_offsx,face_width+face_offsy,1.95]) rotate([0,0,45]) cube([3.4,1.7,4.1], center = true);
	    translate([-0.2,main_width,(29.1+delta_h)/2]) rotate([0,0,45]) cube([3.4,3,30+delta_h], center = true);
	    translate([shroud_offsx,shroud_width+shroud_offsy,((shroud_height + main_height)+4)/2]) rotate([0,0,45]) cube([3,1.5,shroud_height - main_height - 3.99], center = true);
		}
	  // corner #1 rounding
	  translate([foffsx,foffsy,2]) cylinder(r=smchamrad, h=4, $fn=32, center = true);
	  translate([chamrad,chamrad,4]) cylinder(r1=chamrad2, r2=chamrad, h=main_height, $fn=32, center = false);
	  translate([shroud_offsx+1.2,shroud_offsy+1.2,((shroud_height + main_height)+4)/2]) rotate([0,0,45]) cube([1,2.2,shroud_height - main_height - 3.99], center = true);
	  // corner #2 rounding
	  translate([face_length-(foffsx - (2*face_offsx)),foffsy,2]) rotate([0,0,45]) cylinder(r=smchamrad, h=4, $fn=32, center = true);
	  translate([main_length-chamrad,chamrad,4]) cylinder(r1=chamrad2, r2=chamrad, h=main_height, $fn=32, center = false);
	  translate([shroud_length+shroud_offsx-1.2,shroud_offsy+1.2,((shroud_height + main_height)+4)/2]) rotate([0,0,45]) cube([2.2,1,shroud_height - main_height - 3.99], center = true);
	  // corner #3 rounding
	  translate([face_length-(foffsx - (2*face_offsx)),face_width-(foffsy - (2*face_offsy)),2]) rotate([0,0,45]) cylinder(r=smchamrad, h=4, $fn=32, center = true);
	  translate([main_length-chamrad,main_width-chamrad,4]) cylinder(r1=chamrad2, r2=chamrad, h=main_height-0.02, $fn=32, center = false);
	  translate([shroud_length+shroud_offsx-1.2,shroud_width+shroud_offsy-1.2,((shroud_height + main_height)+4)/2]) rotate([0,0,45]) cube([1,2.2,shroud_height - main_height - 3.99], center = true);
	  // corner #4 rounding
	  translate([foffsx,face_width-(foffsy - (2*face_offsy)),2]) rotate([0,0,45]) cylinder(r=smchamrad, h=4, $fn=32, center = true);
	  translate([chamrad,main_width-(chamrad),4]) cylinder(r1=chamrad2, r2=chamrad, h=main_height, $fn=32, center = false);
	  translate([shroud_offsx+1.2,shroud_width+shroud_offsy-1.2,((shroud_height + main_height)+4)/2]) rotate([0,0,45]) cube([2.2,1,shroud_height - main_height - 3.99], center = true);

	  translate([59.06,0,4.1]) cube([1.52,24.51,7.1+delta_h]);			// re-enforcing rib #1
	  translate([117.22,0,4.1]) cube([1.52,24.51,9.1+delta_h]);			// re-enforcing rib #2
	  translate([153,12.95,2]) cube([10,10,11.19+delta_h]);				// light-pipe support
	  rotate([90,0,0]){
		translate([.8,22.3+delta_h,-12.51]) cylinder(r=1.27, h=10.16, $fn=16, center = true);			// end tab detent #1
	  }
	  rotate([90,0,0]){
		translate([176.1,22.3+delta_h,-12.51]) cylinder(r=1.27, h=10.16, $fn=16, center = true);		// end tab detent #2
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
	
	// side slope 1
	translate([-2,((main_width - main_twidth)/2)-.85,face_thick-0.1]) rotate([slope,0,0]) cube([main_length+5,1,main_height+1]); //
	// side slope 3
	translate([-2,main_width-(((main_width - main_twidth)/2)+.01),face_thick-0.1]) rotate([-slope,0,0]) cube([main_length+5,1,main_height+1]); //
	// side slope 2
	translate([-.49,((main_width - main_twidth)/2),face_thick-0.1]) rotate([0,-slope,0]) cube([1,main_width+5,main_height+1]); //
	// side slope 4
	translate([main_length-.49,((main_width - main_twidth)/2),face_thick-0.1]) rotate([0,slope,0]) cube([1,main_width+5,main_height+1]); //

	translate([82,19.1,20+delta_h]) cube([13,4,8]);						// center tab clearance 1
	translate([82,2,21+delta_h]) cube([13,4,8]);						// center tab clearance 2
	translate([139.2,7,-.1]) cube([1.2,20,1.7]);						// decorative slot 1
	translate([0,7,-.1])   cube([140.1,1.2,1.7]);						// decorative slot 2
	translate([139.2,22.8,-.1]) cube([1.2,1.7,4]);						// decorative slot 3
	translate([.99,7,-.1])   cube([1.2,1.2,4]);							// decorative slot 4
	translate([-1,23.9,-4.1]) rotate([45,0,0]) cube([141.1,4,5]);		// decorative chamfer
	translate([30,9,.7]) rotate([180,0,90]) union(){
		char_CIRCLEI();
		translate([0,-4.6,0]) char_C();
		translate([0,-10,0]) char_O();
		translate([0,-17,0]) char_M();
	}
	translate([15,9,3.5]) rotate([0,0,90]) union(){
		// signature
		translate([0,-5,0]) char_K();
		translate([0,-10,0]) char_E();
		translate([0,-15,0]) char_0();
		translate([0,-20,0]) char_F();
		translate([0,-25,0]) char_F();
		translate([0,-110,0]) char_PLUS();
		// dash number (delta_h truncated to next lowest mm)
		if(delta_h <1)	translate([0,-115,0]) char_0();
		if((delta_h >=1)&& (delta_h < 2))	translate([0,-115,0]) char_1();
		if((delta_h >=2)&& (delta_h < 3))	translate([0,-115,0]) char_2();
		if((delta_h >=3)&& (delta_h < 4))	translate([0,-115,0]) char_3();
		if((delta_h >=4)&& (delta_h < 5))	translate([0,-115,0]) char_4();
		if((delta_h >=5)&& (delta_h < 6))	translate([0,-115,0]) char_5();
		if((delta_h >=6)&& (delta_h < 7))	translate([0,-115,0]) char_6();
		if((delta_h >=7)&& (delta_h < 8))	translate([0,-115,0]) char_7();
		if((delta_h >=8)&& (delta_h < 9))	translate([0,-115,0]) char_8();
		if((delta_h >=9)&& (delta_h < 10))	translate([0,-115,0]) char_9();
		if(delta_h >=10)	translate([0,-115,0]) char_X();
	}

//  translate([-10,-10,-10]) cube([50,50,50]);					// section cut (leave commented-out unless needed for debug)
}
union(){
	translate([-.7,7.43,12.45+delta_h]) cube([2.3,10.16,12.95]);		// end tab #1
	translate([175.5,7.43,12.45+delta_h]) cube([2.3,10.16,12.95]);	// end tab #2
}
