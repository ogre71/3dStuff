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
        
        //center hole
        cylinder(h=12, r=5, center=true, $fn = fn);
    }
}