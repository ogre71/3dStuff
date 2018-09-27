letter="sarracenia purpurea";
smallText="Alpena, MI";
    
length = 90;    
textStart = 0; 
height = 2; 

module GetText(bigText, littleText) { 
    union() {         
        translate([textStart, 0, 1.7])
            color("black", 1)
                linear_extrude(height=.301, convexity=4)
                    text(bigText, 
                    font="Bitstream Vera Sans",
                    halign="center",
                    size=7
                    );
        
        translate([textStart, -8, 1.7])
            color("black", 1)
                linear_extrude(height=.301, convexity=4)
                    text(littleText, 
                    font="Bitstream Vera Sans",
                    halign="center",
                    size=5// 3 is too small, doesn't extrude
                          // 4 is readable, but leaves gaps
                    );
            }
}

// First extrusion 
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
            GetText(letter, smallText); 

            rotate([180, 0, 0])
                translate([textStart, 1, -2])
                    GetText(letter, smallText); 
        }
}

// Second Extrusion
union() { 
    GetText(letter, smallText); 

    rotate([180, 0, 0])
        translate([textStart, 1, -2])
            GetText(letter, smallText); 
}

    