include <../param.scad>;
include <../lib/user.scad>;

module part_eccentric() {
    h=3.5;
    $fs = 0.2;
    difference() {
        translate([0,cycloidal_e,0])
            center_cylinder(r=8/2, h=h);
        translate([0,0,-0.05])
            center_cylinder(r=5/2, h=h+0.1);
    }
}