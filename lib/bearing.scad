/**
 *
 */
include <MCAD/bearing.scad>;

module bearing(model=[22,8,7], outline=false,
                material=Steel, sideMaterial=Brass) {

  w = model[2];
  innerD = outline==false ?  model[1]: 0;
  outerD = model[0];

  innerRim = innerD + (outerD - innerD) * 0.2;
  outerRim = outerD - (outerD - innerD) * 0.2;
  midSink = w * 0.1;

  union() {
    color(material)
      difference() {
        // Basic ring
        Ring([0,0,0], outerD, innerD, w, material, material);

        if (outline==false) {
          // Side shields
          Ring([0,0,-epsilon], outerRim, innerRim, epsilon+midSink, sideMaterial, material);
          Ring([0,0,w-midSink], outerRim, innerRim, epsilon+midSink, sideMaterial, material);
        }
      }
  }

  module Ring(pos, od, id, h, material, holeMaterial) {
    color(material) {
      translate(pos)
        difference() {
          cylinder(r=od/2, h=h,  $fs = 0.01);
          color(holeMaterial)
            translate([0,0,-10*epsilon])
              cylinder(r=id/2, h=h+20*epsilon,  $fs = 0.01);
        }
    }
  }

}