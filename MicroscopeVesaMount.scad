;$fn=100;

shaft_diameter = 45;
shaft_width = 10;

plate_length = 95;
plate_thickness = 4;
plate_screw_distance = 75;

module screw_hole(dia){
    cylinder(20, dia/2, dia/2);
    cylinder(15, (dia+5)/2, (dia+5)/2);
}


module plate(){
    hull(){        
        translate([-(shaft_diameter + 5)/2+5, -shaft_diameter/4, 0]){
            difference(){
                cube([plate_thickness, shaft_diameter/2, shaft_width]);
            }
        }
        translate([-(shaft_diameter + 5)/2-2, -plate_length/2, 0]){
            difference(){
                cube([plate_thickness, plate_length, shaft_width]);
            }
        }
    }
}

module clamp(){
    difference(){
        union(){
            hull(){
                cylinder(shaft_width, (shaft_diameter + 5) / 2, (shaft_diameter + 5)/2);
                               
                translate([shaft_diameter/2 + 2, -5, 0])
                    cube([12, 10, shaft_width]);
            }
            
            plate();
        }
        
        union(){
            cylinder(100, shaft_diameter/2, shaft_diameter/2);
            translate([shaft_diameter/2-1, -2, 0])
                #cube([15, 4, shaft_width], center=false);            
            
            // Screw holes for the scope holder
            translate([shaft_diameter/2 + 8, 20, shaft_width/2])
                rotate([90, 0, 0])
                #screw_hole(dia=5);
            
            
            translate([shaft_diameter/2 + 8, -20, shaft_width/2])
                rotate([-90, 0, 0])
                #screw_hole(dia=5);            
            
            // Screw holes for the vesa mount
            translate([-shaft_diameter/2 + 13, -plate_screw_distance/2 , shaft_width /2])
                rotate([0, -90, 0])
                #screw_hole(dia=5);
            
            translate([-shaft_diameter/2 + 13, plate_screw_distance/2 , shaft_width /2])
                rotate([0, -90, 0])
                #screw_hole(dia=5);
        }
    }
    
}

module joiner(neck, shoulder, depth, height, scale=1.2) {

    leftOut = [- neck / 2, 0];
    rightOut = [neck / 2, 0];
    leftIn = [- shoulder / 2, depth];
    rightIn = [shoulder / 2, depth];
    linear_extrude(height = height, scale = scale)
        polygon(points = [leftOut, rightOut, rightIn, leftIn]);
}

clamp();
