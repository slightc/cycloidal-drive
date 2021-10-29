include <../param.scad>;
include <../lib/cycloidal.scad>;
include <../lib/user.scad>;
include <./base.scad>;


part_shell_height = 10;

module part_shell() {
    ha = part_shell_height;
    difference() {      
        linear_extrude(height=ha)
            cut_square(8,motor_size);

        translate([0,0,-0.05])
            center_cylinder(r=31/2+print_delta, h=(ha+0.1));
        
        translate([0,0,ha-7-0.05])
            center_cylinder(r=37/2, h=(7+0.1));
        
        motor_hole(ha);

    translate([0,0,(cycloidal_roller_height-cycloidal_rotor_height)/2])
        cycloidal_roller_hole(-cycloidal_roller_height);
    }
}