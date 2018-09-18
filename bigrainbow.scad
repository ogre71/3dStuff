letter="Big Rainbow";
    
length = 90;    
textStart = 0; 
height = 2; 

color("blue", 1.0)
    translate([-length/2 - 100, -2, 0])
        cube([100, 4, height]);

difference () { 
    translate([-length/2, -10, 0])
        color("white", 1.0) 
            cube([length, 20, height], center=false) ;

    union() {         
        translate([textStart, -5, 1.7])
            color("black", 1)
                linear_extrude(height=.3, convexity=4)
                    text(letter, 
                    font="Bitstream Vera Sans",
                    halign="center"
                    );

        rotate([180, 0, 0])    
            translate([textStart, -5, -.3])
                color("black", .3)
                    linear_extrude(height=1, convexity=4)
                        text(letter, 
                        font="Bitstream Vera Sans",
                        halign="center"
                        );
    }
}

*union() {         
    translate([textStart, -5, 1.7])
        color("black", 1)
            linear_extrude(height=.3, convexity=4)
                text(letter, 
                font="Bitstream Vera Sans",
                halign="center"
                );

    rotate([180, 0, 0])    
        translate([textStart, -5, -.3])
            color("black", 1)
                linear_extrude(height=.3, convexity=4)
                    text(letter, 
                    font="Bitstream Vera Sans",
                    halign="center"
                    );
}

    