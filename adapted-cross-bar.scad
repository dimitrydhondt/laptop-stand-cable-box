$fn=100;

usb_hub_h = 17.3;
usb_hub_w = 124.2;
usb_hub_depth = 49;

power_supply_w = 180;
power_supply_h = 30;
power_supply_d = 47;

cable_w = 6;

d = 115;
mid = 45;
h1 = 30;
h2 = 69;

bar_width = 180;

profile_width = 10;

difference() {
    union() {
        translate([0,bar_width/2,10]) import("CrossBar.stl");
        translate([-mid,-bar_width/2 + profile_width * 2, 0]) side_panel();
        translate([-mid,bar_width/2 - profile_width ,0]) side_panel();
        
        // bottom plate
        translate([12, 0,0]) 
            ct_cube([d - 30, bar_width - profile_width * 4, profile_width]);

        // front
        translate([-mid + 5,0,10])
            ct_cube([profile_width/2, bar_width - profile_width * 4, 10]);

        // back
        translate([d-mid - 5,0,10])
            ct_cube([profile_width/2, bar_width - profile_width * 4, h2 - 30]);
    }
    
    translate([55,0,0]) cable_entry();
    translate([45,0,0]) cable_entry();
    translate([35,0,0]) cable_entry();
    
    translate([0,-10,0]) rotate(90,[0,0,1]) cable_entry();
    translate([0,0,0]) rotate(90,[0,0,1]) cable_entry();
    translate([0,10,0]) rotate(90,[0,0,1]) cable_entry();
}

// For testing dimensions visually
/*
translate([0,bar_width/2,profile_width]) import("Small_leftLeg.stl");
translate([0,bar_width/2, profile_width]) import("Small_RightLeg.stl");
*/

module cable_entry() {
    translate([0,bar_width/2,h2/2 + 15])
        rotate(90,[0,1,0])
            rotate(90,[1,0,0])
                minkowski() {
                    
                    ct_cube([h2, 1 , bar_width]);
                    cylinder(r=(cable_w - 1) / 2);
                }    
}

module side_panel() {
    r=15;
    rotate(90,[1,0,0]) 
        minkowski() {
            linear_extrude(10) 
                polygon([
                    [r,r],
                    [r,h1 - r],
                    [d - r,h2 - r],
                    [d - r, r]
                ]);
            cylinder(r=r);
        }
}

/********************************************************

Utilities

*********************************************************/

module c_cylinder(h, r1, r2) {
    translate([0,0,-h/2]) cylinder(h,r1,r2);
}

// Center cube in 3D space
module c_cube(vector) {
    x = vector[0];
    y = vector[1];
    z = vector[2];
    
    translate([-x/2,-y/2,-z/2]) cube([x,y,z]);
}
    

// Centered cube on top of plane.
module ct_cube(vector) {
    x = vector[0];
    y = vector[1];
    z = vector[2];
    
    translate([-x/2,-y/2,0]) cube([x,y,z]);
}