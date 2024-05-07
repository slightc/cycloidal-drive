include <../param.scad>;
include <../lib/cycloidal.scad>;
include <../lib/user.scad>;

module part_rotor() {
    difference() {    
        // base
        cycloidal_rotor(
            cycloidal_roller_num,
            (cycloidal_diameter)/2,
            cycloidal_e,
            (cycloidal_roller_diameter)/2,
            cycloidal_rotor_height);

        // 轴承安装孔
        translate([0, 0, 0.5]) 
            center_cylinder(r=12/2, h=cycloidal_rotor_height+0.1); // 和轴承过盈配合
        
        // 通孔 和上面一起形成一个台面
        translate([0, 0, -0.05]) 
            center_cylinder(r=10/2, h=cycloidal_rotor_height+0.1);
        
        // 输出
        translate([0, 0, 1]) 
            cycloidal_roller(
                cycloidal_out_roller_num,
                (cycloidal_out_diameter)/2,
                (cycloidal_roller_diameter)/2+cycloidal_e+ print_delta/2,
                cycloidal_rotor_height+1);
    }
}