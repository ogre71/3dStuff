module roundedRect(size, radius, scale)
{
	x = size[0];
	y = size[1];
	z = size[2];

	linear_extrude(height=z, scale=scale)
	hull()
	{
		// place 4 circles in the corners, with the given radius
		translate([(-x/2)+(radius/2), (-y/2)+(radius/2), 0])
		circle(r=radius);
	
		translate([(x/2)-(radius/2), (-y/2)+(radius/2), 0])
		circle(r=radius);
	
		translate([(-x/2)+(radius/2), (y/2)-(radius/2), 0])
		circle(r=radius);
	
		translate([(x/2)-(radius/2), (y/2)-(radius/2), 0])
		circle(r=radius);
	}
}

module shelledRoundedRect(size, radius, scale, thickness) 
{
    x = size[0];
	y = size[1];
	z = size[2];
    
    difference() { 
        roundedRect(size, radius, scale, $fn=20);
        roundedRect([x - thickness, y - thickness, z ], 1, ((x * scale) - thickness)/(x - thickness), $fn=20);
    }
}

module solidPot(shell_thickness) 
{
    // The base
    roundedRect([75,75, shell_thickness], 1, 1, $fn=20);

    // The first tier
    shelledRoundedRect([50, 50, 76], 1, 1.5, shell_thickness);  

    // The second Tier
    translate([0, 0, 76]) 
        shelledRoundedRect([75, 75, 4], 1.5, 1.05, shell_thickness);

    // The third tier
    translate([0, 0, 80])
        shelledRoundedRect([78.75, 78.75, 10], 1.5, 1, shell_thickness);
}

epsilon = .05;

difference() {     
    solidPot(3);
    
    // drainage holes 
    union() { 
        for (a =[-19:6:17])
            translate([a, -40, 3])
                cube([3, 80, 3]);
        
        for (a =[-19:6:17])
            translate([-40, a, 3])
                cube([80, 3, 3]);
    }
}