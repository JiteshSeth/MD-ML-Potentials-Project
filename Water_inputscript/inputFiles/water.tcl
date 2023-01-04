package require solvate
package require topotools

set molname "waters"


#solvate -minmax {{0 0 0} {50 50 50}} -o ${molname}

mol load psf ${molname}.psf pdb ${molname}.pdb

set hyd [atomselect top "type HT"]
$hyd set type 1HT
$hyd set charge 0.4238
set oxy [atomselect top "type OT"]
$oxy set type 2OT
$oxy set charge -0.8476

topo writelammpsdata water.lmpsys

mol delete all
exit

