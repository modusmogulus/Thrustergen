//rocketmotor designer made by modus
$fn = 60;

propellantdensity = 1.8;
propellantmass = 10;
desiredvolume = propellantmass/propellantdensity;
tolerance = 1;
chokesize = 0.1;
ramthickness = 1;
wallthickness = 5;
heightmultiplier = 8;
//r = sqrt(pi/h)
holeradius = sqrt(PI*heightmultiplier)*desiredvolume;

grainpattern = 5;
coolingfins = 10;
finlength = 3;
grainwinglength = 6;
translate([0,0,0]) {
    union(){
        difference() {
            cylinder(holeradius*heightmultiplier, holeradius, holeradius);
            translate([0, 0, wallthickness]){
                cylinder(holeradius*heightmultiplier, holeradius-wallthickness, holeradius-wallthickness);
            }
        }
        for(i = [0:coolingfins]){
            rotate(360/coolingfins * i, [0, 0, 1]) {
                for(j = [0:finlength]) {
                    translate([holeradius+j, 0, 0]) {
                        cylinder(holeradius*heightmultiplier, 2, 2);
                    }
                }
            }
        }
    }
}

//now for the nozzle
translate([100,0,0]) {
    difference() {
        difference() {
            cylinder(holeradius*heightmultiplier/5, holeradius+wallthickness, holeradius-tolerance);
            translate([0, 0, - wallthickness - chokesize]){
                sphere(holeradius - chokesize);
            translate([0, 0, (holeradius*heightmultiplier)/5 - chokesize + wallthickness]){
                sphere(holeradius - chokesize - tolerance*1.5);
                }
            }

        }
        cylinder(holeradius*heightmultiplier/5, chokesize*holeradius, chokesize*holeradius);
    }
}

//propellant grain shaping tool
translate([-100, 0, 0]) {
    union(){
            difference() {
                cylinder(holeradius*heightmultiplier, holeradius+tolerance, holeradius+tolerance);
                translate([0, 0, wallthickness*8]){
                    cylinder(holeradius*heightmultiplier, holeradius-wallthickness+tolerance, holeradius-wallthickness+tolerance);
            }
        }
        
        //ramming rod
        for(i = [0:grainpattern]){
            rotate(360/grainpattern * i, [0, 0, 1]) {
                for(j = [0:grainwinglength]) {
                    translate([j*ramthickness*0.7, 0, 0]) {
                    cylinder(holeradius*heightmultiplier, ramthickness, ramthickness);
                    }
                }
            }
        }
        cylinder(holeradius*heightmultiplier, ramthickness*3, ramthickness*3);
    }
}


echo("Calculated motor thrust: " + str(desiredvolume*5));