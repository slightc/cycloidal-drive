include <../param.scad>;
include <../lib/cycloidal.scad>;
include <../lib/user.scad>;


module cycloidal_roller_hole(h){
    cycloidal_roller(
        cycloidal_roller_num,
        cycloidal_diameter/2,
        (cycloidal_roller_diameter+print_delta)/2,
        h);
}

module motor_hole(ha) {
    translate([0,0,-0.05 ])
    rotate([0, 0, 45])
        cycloidal_roller(
            4,
            sqrt(2)*(motor_hole_size)/2,
            (3.6)/2,
            ha+0.1);
}

h1 = 3.5;
h2 = cycloidal_rotor_height+0.1;
ha = h1+h2;

part_base_height = ha;

module part_base() {
    difference() {      
        linear_extrude(height=ha)
            cut_square(8,motor_size);
        
        translate([0,0,h1+0.05])
            center_cylinder(r=24/2, h=-(h1+0.1));
        
        translate([0,0,ha - h2])
            center_cylinder(
                r=(cycloidal_diameter)/2,
                h=h2+0.1);

        translate([0,0,ha - h2 -(cycloidal_roller_height - h2)/2 - 0.1 ])
            cycloidal_roller_hole(cycloidal_roller_height);

        rotate([0, 0, 8.5]) 
            translate([0,0,ha - h2 ])
                cycloidal_roller(
                    cycloidal_roller_num,
                    cycloidal_diameter/2-1,
                    (cycloidal_roller_diameter-0.5)/2,
                    ha+0.1);

        translate([0,0,ha - h2 ])
            rotate([0, 0, 8.5]) 
                cycloidal_roller(
                    cycloidal_roller_num,
                    cycloidal_diameter/2-1,
                    (cycloidal_roller_diameter-0.5)/2,
                    ha+0.1);

        motor_hole(ha);
    }
}

// part_base();