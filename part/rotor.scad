include <../param.scad>;
include <../lib/cycloidal.scad>;
include <../lib/user.scad>;

module part_rotor() {
    difference() {    
        cycloidal_rotor(
            cycloidal_roller_num,
            (cycloidal_diameter)/2,
            cycloidal_e,
            (cycloidal_roller_diameter)/2,
            cycloidal_rotor_height);

        translate([0, 0, 0.5]) 
            center_cylinder(r=12/2+print_delta, h=cycloidal_rotor_height+0.1);
        
        translate([0, 0, -0.05]) 
            center_cylinder(r=10/2, h=cycloidal_rotor_height+0.1);
        
        translate([0, 0, 1]) 
            cycloidal_roller(
                cycloidal_out_roller_num,
                (cycloidal_out_diameter)/2,
                (cycloidal_roller_diameter)/2+cycloidal_e+ print_delta,
                cycloidal_rotor_height+1,0.2);
    }
}