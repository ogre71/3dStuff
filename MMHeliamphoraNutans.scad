letter="Big Rainbow";
    
length = 140;    

translate([-length/2, -10, 0])
    color("white", 1.0) 
        cube([length, 20, 3], center=false) ;

color("blue", 1.0)
    translate([-length/2 - 100, -2, 0])
        cube([100, 4, 3]);