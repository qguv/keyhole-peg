Wall=2;
Pin_height=3;
Hole_diameter=4;
Pin_top_diameter=5;
Pin_thin_diameter=3;
Screw_head_diameter=8;
Screw_head_height=4;

/* [Advanced] */
Punch = 0.001;
$fn = 90;

module body() {
    risen = Wall + Screw_head_height;
    hull() {
        cylinder(h=risen, d=Screw_head_diameter + Wall*2);
        
        translate([screw_clearance_d + Pin_top_diameter/2, 0, 0])
        cylinder(
            h=risen,
            d=Pin_top_diameter
        );
    }
}

module pin() {
    pin_bottom_center = [screw_clearance_d + Pin_top_diameter/2, 0, Wall + Screw_head_height];

    // center rod
    translate(pin_bottom_center + [0,0,-Punch]) cylinder(
        h=Pin_height+Punch,
        d=Pin_thin_diameter
    );

    // top flare
    translate(pin_bottom_center + [0,0,Pin_height/2]) cylinder(
        h = Pin_height/2,
        d2=Pin_top_diameter,
        d1=Pin_thin_diameter
    );

    // bottom flare
    translate(pin_bottom_center + [0,0,-Punch]) cylinder(
        h = Pin_height/2+Punch,
        d2=Pin_thin_diameter,
        d1=Pin_top_diameter
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

        union() {
            body();
            pin();
        }

        screw_negative();
    }
}

screw_clearance_d = Screw_head_diameter/2 + Wall;
all();
