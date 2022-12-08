Wallplate(diameter=100, depth=35, thickness=3);

module Wallplate(diameter, depth, thickness=3) {
    outer_radius = diameter / 2;
    inner_radius = outer_radius - thickness;

    difference() {
        union() {
            cube([diameter, diameter, 2], center=true);
            cylinder(depth * 2, outer_radius, outer_radius, $fn=1000, center=true);
        };

        cylinder(depth * 2 + 2, inner_radius, inner_radius, $fn=1000, center=true);
    };
    // difference(){
    //     cylinder(depth + 1, inner_radius, inner_radius, $fn=1000);
    // };
}
