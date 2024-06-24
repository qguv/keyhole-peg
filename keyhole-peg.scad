$fn = 90;
fudge = 0.001;

module outer(wall, hole_d, risen, keyhole_d) {
    clearance = max((keyhole_d - risen)/2, wall);
    pillar_base = min(keyhole_d - 2, hole_d);
    pillar_d = hole_d + wall*2;

    hull() {
        cylinder(h=risen, d=pillar_d);
        
        translate([hole_d/2 + clearance + hole_d/2, 0, 0])
        cylinder(
            h=risen,
            d=pillar_d
        );
    }
    
    translate([
        hole_d/2 + clearance + hole_d/2,
        0,
        risen-fudge
    ]) cylinder(
        h=risen+fudge,
        d1=pillar_base,
        d2=keyhole_d
    );
}

module all(wall=2, hole_d=4, risen=2, keyhole_d=5) {
    difference() {

        // outer
        outer(
            wall=wall,
            hole_d=hole_d,
            risen=risen,
            keyhole_d=keyhole_d
        );

        // hole
        translate([0,0,-fudge]) cylinder(h=risen+2*fudge, d=hole_d);
    }
}

all();