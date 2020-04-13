
jack_length = 16.5;
jack_width = 15;

wall_height = 10;
wall_thickness = 4;

catch_overhang = 2;

small_clip_depth = catch_overhang;
big_clip_depth = catch_overhang + 2;
big_clip_clearance = 4;
small_clip_clearance = 6.5;

wall_extension = 15;

outer_length =
    jack_length + small_clip_depth + big_clip_depth + (wall_thickness * 2);
outer_width = jack_width + (wall_thickness * 2);

module clip_catch() {
  rotate([ 90, 0, 0 ]) {
    linear_extrude(height = outer_width) {
      polygon(points =
                  [
                    [ 0, 0 ], [ catch_overhang, 0 ],
                    [ wall_thickness, catch_overhang ], [ 0, catch_overhang ]
                  ],
              paths = [[ 0, 1, 2, 3 ]]);
    }
  }
}

module keystone() {
  union() {
    difference() {
      difference() {
        cube([ outer_length, outer_width, wall_height ]);
        translate([ wall_thickness, wall_thickness, big_clip_clearance ]) {
          cube([ outer_length, jack_width, wall_height ]);
        }
      }
      translate([ wall_thickness + small_clip_depth, wall_thickness, 0 ]) {
        cube([ jack_length, jack_width, wall_height + 1 ]);
      }
    }

    cube([ wall_thickness, outer_width, wall_height ]);

    cube([
      wall_thickness + small_clip_depth, outer_width,
      small_clip_clearance
    ]);

    translate([ 2, 23, 8 ]) {
      clip_catch();
    }

    translate([ 26.5, 0, 0 ]) {
      cube([ 4, 23, 10 ]);
    }

    translate([ 28.5, 0, 8 ]) {
      rotate([ 0, 0, -180 ]) {
        clip_catch();
      }
    }
  }
}

module keystone_cutout(h) {
  color("red") cube([ outer_width, outer_length, h ]);
}

hole_cloae = 5.5;
hole_far = 88.8;

difference(){

  union() {
    difference() {
      color("green") translate([ 372, 783, 0 ])
          import("daeksel-2.stl", convexity = 3);

      translate([ outer_length + 7, 55, 0 ]) rotate([ 0, 0, 90 ])
          keystone_cutout(10);


      translate([ outer_length + 7, 16, 0 ]) rotate([ 0, 0, 90 ])
          keystone_cutout(10);
    }

    translate([ outer_length + 7, 55, 9.25 ]) rotate([ 0, 180, 0 ])      keystone();

    translate([ outer_length + 7, 16, 9.25 ]) rotate([ 0, 180, 0 ])
        keystone();

    translate([22, hole_far, 2.3])
    linear_extrude(height=6.5, $fn=100)
    circle(d=7.5);

    translate([22, hole_cloae, 2.3])
    linear_extrude(height=6.5, $fn=100)
    circle(d=7.5);
  }


   #translate([22,  hole_far, 4.3])
  linear_extrude(height=20, $fn=100)
  circle(d=6);

   #translate([22,  hole_cloae, 4.3])
  linear_extrude(height=20, $fn=100)
  circle(d=6);


  translate([22, hole_cloae, 2.3])
  linear_extrude(height=2, scale=6/3.0, $fn=100)
  circle(d=3);


  translate([22, hole_far, 2.3])
  linear_extrude(height=2, scale=6/3.0, $fn=100)
  circle(d=3);
}









