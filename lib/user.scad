
module center_cylinder(r,h) {
    translate([0, 0, h>0?0:h]) {        
        linear_extrude(height=h>0?h:-h) {
            circle(r=r);
        }
    }
}

module cut_square(cut,size, center=true) {
    offset(delta=cut,chamfer=true)
            square(size-cut*2, center);
}