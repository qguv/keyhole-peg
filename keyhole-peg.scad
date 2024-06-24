$fn = 90;
fudge = 0.001;

module outer(wall, hole_d, keyhole_d, screw_head_d, screw_head_h) {
    risen = wall + screw_head_h;
    pin_base = min(keyhole_d - 2, hole_d);
    screw_clearance_d = screw_head_d/2 + wall;

    hull() {
        cylinder(h=risen, d=screw_head_d + wall*2);
        
        translate([screw_clearance_d + keyhole_d/2, 0, 0])
        cylinder(
            h=risen,
            d=keyhole_d
        );
    }
    
    translate([
        screw_clearance_d + keyhole_d/2,
        0,
        wall + screw_head_h - fudge
    ]) cylinder(
        h=wall+fudge,
        d1=pin_base,
        d2=keyhole_d
    );
}

module all(wall=2, hole_d=4, keyhole_d=5, screw_head_d=8, screw_head_h=4) {
    difference() {

        // outer
        outer(
            wall=wall,
            hole_d=hole_d,
            keyhole_d=keyhole_d,
            screw_head_d=screw_head_d,
            screw_head_h=screw_head_h
        );

        // hole
        translate([0,0,-fudge]) cylinder(
            h=fudge + wall + screw_head_h + fudge,
            d=hole_d
        );

        // countersink
        translate([0, 0, wall]) cylinder(
            h=screw_head_h + fudge,
            d1=hole_d,
            d2=screw_head_d
        );
    }
}

all();