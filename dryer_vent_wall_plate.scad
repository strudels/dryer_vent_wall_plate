Wallplate(diameter=100, depth=35, thickness=3);

module Wallplate(diameter, depth, thickness=3) {
    outer_radius = diameter / 2;
    inner_radius = outer_radius - thickness;

    difference() {
        union() {
            translate([0, 0, 1]) cube([diameter, diameter, 2], center=true);
            cylinder(depth, outer_radius, outer_radius, $fn=1000);
        };

        translate([0, 0, -1]) cylinder(depth + 2, inner_radius, inner_radius, $fn=1000);
    };
    // difference(){
    //     cylinder(depth + 1, inner_radius, inner_radius, $fn=1000);
    // };
}
