include <MCAD/stepper.scad>;
include <./lib/bearing.scad>

include <./part/base.scad>;
include <./part/rotor.scad>;
include <./part/eccentric.scad>;
include <./part/shell.scad>;
include <./part/out.scad>;

fs_all = 0;
fs1 = 0.5;
fs2 = 0.2;
stop1 = false;
stop2 = true;

module assem_motor() {
    color(BlackPaint,0.5) translate([0, 0, 1])
        rotate([180,0,0])
            motor(Nema17,NemaShort);
}

module assem_base() {
    part_base();
}

module assem_rotor(theta=0) {
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

module assem_eccentric(theta=0) {
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

module assem_out(theta=0) {
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

function calc_theta(stop, default = 0) =
    stop ? default : 360 * (cycloidal_roller_num - 1) * $t;

function get_fs(primary, sub) = primary > 0.01 ? primary : sub;

module assem_all(){
    $fs = get_fs(fs_all, fs1);
    theta = calc_theta(stop1);
    assem_motor();
    assem_base();
    assem_rotor(theta);
    assem_rollers();
    assem_eccentric(theta);
    assem_shell();
    assem_out(theta);
}
assem_all();

module assem_all2(){
    $fs = get_fs(fs_all, fs2);
    theta = calc_theta(stop2);
    d = 20;
    translate([80,0,-30]){
        assem_motor();
        assem_eccentric(theta);
        translate([0,0,d]) {
            assem_base();
            translate([0,0,d]) {
                assem_rotor(theta);
                assem_rollers();
                translate([0,0,d]) {
                    assem_out(theta);
                    translate([0,0,d]) {
                        assem_shell();
                    }
                }
            }
        }        
    }
}
assem_all2();
