include <../param.scad>;
include <../lib/cycloidal.scad>;
include <../lib/user.scad>;
include <./base.scad>;


module part_out() {
    ha = 10;
    difference() {        
        union(){
            center_cylinder(r=25/2, h=ha);
            center_cylinder(r=28/2, h=ha-7-0.2);
        }

        translate([0, 0, ha+0.1]) 
            center_cylinder(r=5.5/2, h=-(ha+1));

        translate([0, 0, 3]) 
            cycloidal_roller(
                cycloidal_out_roller_num,
                (cycloidal_out_diameter)/2,
                (cycloidal_roller_diameter+print_delta)/2,
                -(cycloidal_roller_height));

        translate([0, 0, ha-6]) {
            rotate([0, 0, 360/12]) 
                cycloidal_roller(
                    6,
                    (18)/2,
                    (cycloidal_roller_diameter+print_delta)/2,
                    (cycloidal_roller_height));
        }
    }
}