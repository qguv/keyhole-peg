Wall=2;
Hole_diameter=4;
Keyhole_diameter=5;
Screw_head_diameter=8;
Screw_head_height=4;

/* [Advanced] */
Punch = 0.001;
$fn = 90;

module outer() {
    risen = Wall + Screw_head_height;
    pin_base = min(Keyhole_diameter - 2, Hole_diameter);
    screw_clearance_d = Screw_head_diameter/2 + Wall;

    hull() {
        cylinder(h=risen, d=Screw_head_diameter + Wall*2);
        
        translate([screw_clearance_d + Keyhole_diameter/2, 0, 0])
        cylinder(
            h=risen,
            d=Keyhole_diameter
        );
    }
    
    translate([
        screw_clearance_d + Keyhole_diameter/2,
        0,
        Wall + Screw_head_height - Punch
    ]) cylinder(
        h=Wall+Punch,
        d1=pin_base,
        d2=Keyhole_diameter
    );
}

module screw_negative() {

    // hole
    translate([0,0,-Punch]) cylinder(
        h=Punch + Wall + Screw_head_height + Punch,
        d=Hole_diameter
    );

    // countersink
    translate([0, 0, Wall]) cylinder(
        h=Screw_head_height + Punch,
        d1=Hole_diameter,
        d2=Screw_head_diameter
    );
}

module all() {
    difference() {
        outer();
        screw_negative();
    }
}

all();
