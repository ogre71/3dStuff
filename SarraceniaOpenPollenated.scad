// LetterBlock.scad - Basic usage of text() and linear_extrude()

// Module instantiation
LetterBlock("Sarracenia");

// Module definition.
// size=30 defines an optional parameter with a default value.
module LetterBlock(letter, size=10, length=20) {
    difference() {
        translate([0, 
                   0, //-size / 2.5, 
                   0 // size / 4
                  ]) 
            cube([size * 20 , 
                  size * 2.4, 
                  size / 10 
                 ], center=true);
    
        difference() {
            difference() {
                union() {
                    translate([-size * 4.5,
                            0, 
                            0]) {
                        // convexity is needed for correct preview
                        // since characters can be highly concave
                        linear_extrude(height=size / 2, convexity=4)
                            text(letter, 
                                size=size*22/30,
                                font="Bitstream Vera Sans",
                                halign="center"
                                //, valign="center"
                                );
                    }
                    
                    translate([-size * 4.7, 
                            -size, 
                            0
                            ]) {
                        linear_extrude(height=size / 2, convexity=4)
                            text("Open Pollenated 2016", 
                                size=size*22/30,
                                font="Bitstream Vera Sans",
                                halign="center"
                                //,valign="center"
                                );
                    }
                }
                
                *cube([size * 20 , 
                        size * 2.4, 
                        size / 20 
                        ], center=true);
                }
            }

            translate([10, 0, -size / 4])
                linear_extrude(height = size / 2)
                    polygon(points=[[0, 0], [size * 10, -size * 1.2], [size * 10, size * 1.2 + 1], [0, size * 1.2 + 1]]);
        }
}

echo(version=version());

