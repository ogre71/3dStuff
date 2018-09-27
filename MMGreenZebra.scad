letter="Green Zebra";
    
length = 90;    
textStart = 0; 
height = 2; 

difference () { 
    color("white", 1.0)
    union() { 
        //stem
        translate([-length/2 - 100, -2, 0])
            cube([100, 4, height]);
        
        // tapered neck 
        linear_extrude(height) { 
            polygon(points=[[-length/2 -30, 0], [-length / 2, +10], [-length /2, -10], [-length / 2 - 30, 0]]);
        } 
        
        //Broad flat area for text
        translate([-length/2, -10, 0])
            cube([length, 20, height], center=false) ;
    }

    // holes for text 
    color("black", 1) 
        union() {         
            translate([textStart, -4, 1.7])
                linear_extrude(height=.3, convexity=4)
                    text(letter, 
                    font="Bitstream Vera Sans",
                    halign="center"
                    );

            rotate([180, 0, 0])    
                translate([textStart, -4, -.3])
                    linear_extrude(height=1, convexity=4)
                        text(letter, 
                        font="Bitstream Vera Sans",
                        halign="center"
                        );
        }
}

// solid text, for multi-part extrusion 
*union() {         
    translate([textStart, -4, 1.7])
        color("black", 1)
            linear_extrude(height=.3, convexity=4)
                text(letter, 
                font="Bitstream Vera Sans",
                halign="center"
                );

    rotate([180, 0, 0])    
        translate([textStart, -4, -.3])
            color("black", 1)
                linear_extrude(height=.3, convexity=4)
                    text(letter, 
                    font="Bitstream Vera Sans",
                    halign="center"
                    );
}

    