$fn = 90;
fudge = 0.001;

module outer(wall, hole_d, risen, keyhole_d, screw_d) {
    pin_base = min(keyhole_d - 2, hole_d);
    screw_clearance_d = screw_d/2 + wall;

    hull() {
        cylinder(h=risen, d=hole_d + wall*2);
        
        translate([screw_clearance_d + keyhole_d/2, 0, 0])
        cylinder(
            h=risen,
            d=keyhole_d
        );
    }
    
    translate([
        screw_clearance_d + keyhole_d/2,
        0,
        risen-fudge
    ]) cylinder(
        h=risen+fudge,
        d1=pin_base,
        d2=keyhole_d
    );
}

module all(wall=2, hole_d=4, risen=2, keyhole_d=5, screw_d=8) {
    difference() {

        // outer
        outer(
            wall=wall,
            hole_d=hole_d,
            risen=risen,
            keyhole_d=keyhole_d,
            screw_d=screw_d
        );

        // hole
        translate([0,0,-fudge]) cylinder(h=risen+2*fudge, d=hole_d);
    }
}

all();