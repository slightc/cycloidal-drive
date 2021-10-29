include <MCAD/stepper.scad>;
include <./lib/bearing.scad>

include <./part/base.scad>;
include <./part/rotor.scad>;
include <./part/eccentric.scad>;
include <./part/shell.scad>;
include <./part/out.scad>;

theta = 360 * (cycloidal_roller_num - 1)* $t;

module assem_motor() {
    color(BlackPaint,0.5) translate([0, 0, 1])
        rotate([180,0,0])
            motor(Nema17,NemaShort);
}

module assem_base() {
    part_base();
}

module assem_rotor() {
    translate([cycloidal_e*sin(theta),cycloidal_e*cos(theta),3.5+0.05])
    rotate(theta/(cycloidal_roller_num-1))
        union(){
            color("Blue") part_rotor();
            color(Steel,0.5) translate([0,0,0.5]) bearing([12,8,3.5]);
        }
}

module assem_rollers() {
    color(Steel,0.4) translate([0,0,3.5 - (cycloidal_roller_height-4)/2 ])
        cycloidal_roller(
            cycloidal_roller_num,
            cycloidal_diameter/2,
            (cycloidal_roller_diameter)/2,
            cycloidal_roller_height, 0.1);
}

module assem_eccentric() {
    rotate([0,0,-theta]) translate([0, 0, 4])
        part_eccentric();
}

module assem_shell() {
    translate([0,0,part_base_height+0.01])
        union(){
            color("Tan") part_shell();
            color(Steel,0.5) translate([0,0,part_shell_height-7]) bearing([37,25,7]);
        }
}

module assem_out() {
    translate([0,0,part_base_height+0.01])
        rotate(theta/(cycloidal_roller_num-1))
            union(){
                part_out();
                color(Steel,0.4) translate([0, 0, 3])
                    cycloidal_roller(
                        cycloidal_out_roller_num,
                        (cycloidal_out_diameter)/2,
                        (cycloidal_roller_diameter)/2,
                        -(6),0.2);
            }
}

assem_motor();
assem_base();
assem_rotor();
assem_rollers();
assem_eccentric();
assem_shell();
assem_out();
