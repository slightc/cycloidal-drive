/**
 * 摆线针轮驱动
 */

function psi(t,N,Rn,E) = 
    -atan(sin(t*(1-N))/(Rn/(E*N) - cos(t*(1-N))));

function cycloidal_rotor_path(N,Rn,E,rn,fs=$fs/5) = 
    [for (t = [fs:fs:360]) [
        +Rn*cos(t) - rn*cos(t-psi(t,N,Rn,E)) - E*cos(N*t),
        -Rn*sin(t) + rn*sin(t-psi(t,N,Rn,E)) + E*sin(N*t),
    ]];

module cycloidal_rotor(N,Rn,E,rn,h,fs=$fs/5) {
    linear_extrude(height = h)
        polygon(cycloidal_rotor_path(N,Rn,E,rn,fs));
}

module cycloidal_roller(N,Rn,rn,h,fs=$fs) {
    translate([0, 0, h>0?0:h])
    linear_extrude(height=h>0?h:-h)
        for (n=[0:N-1]) {
            translate([Rn*sin(360*n/N), Rn*cos(360*n/N), 0])
                circle(rn,$fs = fs);
        }
}

module cycloidal_test() {
    $fs = 0.5;
    theta = 360 * $t;

    color("red")
        translate([0.75*sin(theta),0.75*cos(theta),1])
            rotate(theta/(21-1))
                cycloidal_rotor(21,18,0.75,1.5,4);

    cycloidal_roller(21,18,1.5,6);
}

// cycloidal_test();

