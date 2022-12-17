include <openscad-fillets/fillets3d.scad>
// 3D printer has a fixed layer height.
// This can be used by e.g. fillets to determine the best possible fillet slicing
LAYER_HEIGHT = 0.2;

Wallplate(
    plate_length=125,
    cylinder_diameter=100,
    depth=30,
    cylinder_thickness=2
);

module Wallplate(
    plate_length,
    cylinder_diameter,
    depth,
    cylinder_thickness=3,
    plate_depth=4,
    plate_thickness=2,
) {
    outer_radius = cylinder_diameter / 2;
    inner_radius = outer_radius - cylinder_thickness;

    difference() {
        // Union of plate and cylinder
        union() {
            // plate
            // uses minkowski for rounded corners
            // uses topFillet for rounded edges (aka fillets...)
            difference() {
                // Outer plate shape
                minkowski() {
                    cylinder_radius = plate_length/10;
                    cube_length = plate_length-cylinder_radius;

                    topFillet(
                        t=plate_depth/2,
                        r=plate_depth,
                        s=plate_depth/LAYER_HEIGHT,
                        e=1
                    ) cube ([cube_length, cube_length, plate_depth], center=true);
                    cylinder(r=cylinder_radius, $fn=100);
                };

                // Inner plate shape, that is subtracted from outer plate to hollow it
                inner_plate_length = plate_length - 1;
                inner_plate_depth = plate_depth - plate_thickness;
                translate([0, 0, -(plate_depth - inner_plate_depth)]) minkowski() {
                    cylinder_radius = plate_length/10;
                    cube_length = inner_plate_length-inner_plate_length/10;

                    topFillet(
                        t=inner_plate_depth/2,
                        r=inner_plate_depth,
                        s=inner_plate_depth/LAYER_HEIGHT,
                        e=1
                    ) cube ([cube_length, cube_length, inner_plate_depth], center=true);
                    cylinder(r=cylinder_radius, $fn=100);
                };
            }
            // Main cylinder insert
            cylinder(depth * 2, outer_radius, outer_radius, $fn=1000, center=true);
        };

        // This is the hole in the middle of the whole thing
        cylinder(depth * 2 + 2, inner_radius, inner_radius, $fn=1000, center=true);
    };
}
