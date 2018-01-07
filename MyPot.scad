fn = 40;

module roundedRect(size, radius, scale)
{
	x = size[0];
	y = size[1];
	z = size[2];

	linear_extrude(height=z, scale=scale)
	hull()
	{
		// place 4 circles in the corners, with the given radius
		translate([(-x/2)+radius, (-y/2)+radius, 0])
		circle(r=radius, $fn=fn);
	
		translate([(x/2)-radius, (-y/2)+radius, 0])
		circle(r=radius, $fn=fn);
	
		translate([(-x/2)+radius, (y/2)-radius, 0])
		circle(r=radius, $fn=fn);
	
		translate([(x/2)-radius, (y/2)-radius, 0])
		circle(r=radius, $fn=fn);
	}
}

module shelledRoundedRect(size, radius, scale, thickness) 
{
    x = size[0];
	y = size[1];
	z = size[2];
    
    difference() { 
        roundedRect(size, radius, scale, $fn=20);
        roundedRect([x - thickness, y - thickness, z ], radius, scale /*((x * scale) - thickness)/(x - thickness)*/, $fn=fn);
    }
}

module solidPot(shell_thickness, radius) 
{
    
    // The base
    roundedRect([75,75, shell_thickness], radius, 1, $fn=fn);

    // The first tier
    shelledRoundedRect([50, 50, 76], radius, 1 + (71.25 - 50) / 50, shell_thickness);  

    // The second Tier
    translate([0, 0, 76]) 
        shelledRoundedRect([71.25, 71.25, 4], radius * (1 + (71.25 - 50) / 50), 1 + (75 - 71.25) / 71.25, shell_thickness * (1 + (71.25 - 50) / 50));

    // The third tier
    translate([0, 0, 80])
        shelledRoundedRect([75, 75, 10], radius * (1 + (75 - 50) / 50), 1, shell_thickness * (1 + (75 - 50) / 50));
}

epsilon = .05;
radius = 5; 
thickness = 3;

difference() {     
    union() { 
        solidPot(3, radius);
        
        r = 4;
        offset = .4; 
        
        //posts
        translate([-75/2 + r,-75/2 + radius * 3 + r,0])
            cylinder(h=thickness * 2.5, r=r, center=false, $fn = fn);    
        translate([-75/2 + r + offset,-75/2 + radius * 3 + r, thickness * 2])
            cylinder(h=1, r=r, center=false, $fn = fn);        
        
        translate([-75/2 + r,75/2 - radius * 3 - r,0])
            cylinder(h=thickness * 2.5, r=r, center=false, $fn = fn); 
        translate([-75/2 + r + offset,75/2 - radius * 3 - r, thickness * 2])
            cylinder(h=1, r=r, center=false, $fn = fn);    
        
        translate([-75/2 + radius * 3 + r,-75/2 + r,0])
            cylinder(h=thickness * 2.5, r=r, center=false, $fn = fn);    
        translate([-75/2 + radius * 3 + r, -75/2 + r  + offset, thickness * 2])
            cylinder(h=1, r=r, center=false, $fn = fn);    
        
        translate([75/2 - radius * 3 - r,-75/2 + r,0])
            cylinder(h=thickness * 2.5, r=r, center=false, $fn = fn);
        translate([75/2 - radius * 3 - r,-75/2 + r + offset, thickness * 2])
            cylinder(h=1, r=r, center=false, $fn = fn);    
        
        //joiners
        difference() { 
            translate([+75/2 - radius * 2,-75/2 + radius * 1.5 + r, thickness])
                cube([radius * 4.25, 15, thickness]);  
            
            union() { 
                translate([+75/2 + radius,-75/2 + radius * 3 + r,0])
                    cylinder(h=10 + thickness, r=r+r/10, center=false, $fn = fn);    
            
                translate([+75/2,-75/2 + radius + r, 0])
                    cube([20, 20, thickness + .2]);    
            }
        }

        difference() { 
            translate([+75/2 - radius * 2,75/2 - radius * 4.5 - r, thickness * .9])
                cube([radius * 4.25, 15, thickness]);  
            
            union() { 
                translate([+75/2 + radius,75/2 - radius * 3 - r,0])
                    cylinder(h=10 + thickness, r=r+r/10, center=false, $fn = fn);    
                
                translate([+75/2, 75/2 - radius * 5 - r, 0])
                    cube([20, 20, thickness + .2]);    
            }
        }

        difference() { 
            translate([-75/2 + radius * 1.5 + r, +75/2 - radius * 2, thickness])
                cube([15,radius * 4.25,  thickness]);  
            
            union() { 
                translate([-75/2 + radius * 3 + r,+75/2 + radius,0])
                    cylinder(h=10 + thickness, r=r+r/10, center=false, $fn = fn);    
                    
                translate([-75/2 + radius * 2, 75/2, 0])
                    cube([20, 20, thickness + .2]);    
            }
        
        }
        
        difference() { 
            translate([75/2 - radius * 4.5 - r,+75/2 - radius * 2, thickness * .9])
                cube([ 15,radius * 4.25, thickness]);  
            
            union() { 
                translate([75/2 - radius * 3 - r,+75/2 + radius,0])
                    cylinder(h=10 + thickness, r=r+r/10, center=false, $fn = fn);    
                        
                translate([75/2 - radius * 4 - r, 75/2, 0])
                    cube([20, 20, thickness + .2]);    
            }
        }
    }
    
    // drainage holes 
    union() { 
        for (a =[-19:6:17])
            translate([a, -(50 + thickness * 2)/2, 3])
                cube([3, 50 + thickness * 2, 3]);
        
        for (a =[-19:6:17])
            translate([-(50 + thickness * 2)/2, a, 3])
                cube([50 + thickness * 2, 3, 3]);
        
        translate([-75 / 2 + radius + thickness, -75/2 + radius + thickness, 0])
            cylinder(h=12, r=5, center=true, $fn = fn);
        translate([75 / 2 - radius - thickness, -75/2 + radius + thickness, 0])
            cylinder(h=12, r=5, center=true, $fn = fn);
        translate([-75 / 2 + radius + thickness, 75/2 - radius - thickness, 0])
            cylinder(h=12, r=5, center=true, $fn = fn);
        translate([75 / 2 - radius - thickness, 75/2 - radius - thickness, 0])
            cylinder(h=12, r=5, center=true, $fn = fn);
        
        translate([-50 / 2 + radius , -50/2 + radius , 0])
            cylinder(h=12, r=5/2, center=true, $fn = fn);
        translate([50 / 2 - radius, -50/2 + radius, 0])
            cylinder(h=12, r=5/2, center=true, $fn = fn);
        translate([-50 / 2 + radius, 50/2 - radius, 0])
            cylinder(h=12, r=5/2, center=true, $fn = fn);
        translate([50 / 2 - radius, 50/2 - radius, 0])
            cylinder(h=12, r=5/2, center=true, $fn = fn);
        
        cylinder(h=12, r=10, center=true, $fn = fn);
    }
}