package require topotools


set molname "waters"



mol load psf ${molname}.psf pdb ${molname}.pdb

set hyd [atomselect top "type HT"]
$hyd set type 1HT
$hyd set charge 0.410
set oxy [atomselect top "type OT"]
$oxy set type 2OT
$oxy set charge -0.820

topo writelammpsdata water.lmpsys

mol delete all
exit

