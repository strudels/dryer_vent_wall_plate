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
    plate_thickness=2
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
                minkowski() {
                    cube_length = plate_length-plate_length/10;

                    topFillet(
                        t=plate_thickness/2,
                        r=plate_thickness,
                        s=plate_thickness/LAYER_HEIGHT,
                        e=1
                    ) cube ([cube_length, cube_length, plate_thickness], center=true);
                    cylinder(r=plate_length/10, $fn=100);
                };

                translate([0, 0, -1]) minkowski() {
                    inner_plate_length = plate_length - 1;
                    inner_plate_thickness = plate_thickness - 1;
                    cube_length = inner_plate_length-inner_plate_length/10;

                    topFillet(
                        t=inner_plate_thickness/2,
                        r=inner_plate_thickness,
                        s=inner_plate_thickness/LAYER_HEIGHT,
                        e=1
                    ) cube ([cube_length, cube_length, inner_plate_thickness], center=true);
                    cylinder(r=plate_length/10, $fn=100);
                };
            }
            cylinder(depth * 2, outer_radius, outer_radius, $fn=1000, center=true);
        };

        // This is the hole in the middle of the whole thing
        cylinder(depth * 2 + 2, inner_radius, inner_radius, $fn=1000, center=true);
    };
}
