package require psfgen
package require topotools

# Types in wat.pdb; OT, HT, and MW
# Names in wat.pdb; OH2 H1 H2 MW
# Segname in wat.pdb; TIP4P
# Resname in wat.pdb; TIP4
#
set pkmlOutput "pkml_output"
set molname "waters"

mol load pdb ${pkmlOutput}.pdb
set sel [atomselect top "type OH 1HH 2HH MO"]
$sel set segname TIP4P
$sel set resname TIP4

set sel [atomselect top "type OH"]
$sel set type OT
$sel set name OH2
set sel [atomselect top "type 1HH"]
$sel set type HT
$sel set name H1
set sel [atomselect top "type 2HH"]
$sel set type HT
$sel set name H2
set sel [atomselect top "type MO"]
$sel set type MO
$sel set name M1

set sel [atomselect top "type HT OT MO"]
$sel writepdb ${molname}.pdb

topology water.top
segment TIP {pdb ${molname}.pdb}
coordpdb ${molname}.pdb TIP
writepsf ${molname}.psf
writepdb ${molname}.pdb

mol load psf ${molname}.psf pdb ${molname}.pdb

set hyd [atomselect top "type HT"]
$hyd set type 1HT
$hyd set charge 0.0000
set oxy [atomselect top "type OT"]
$oxy set type 2OT
$oxy set charge 0.5564
set mw [atomselect top "type MO"]
$mw set type 3MO
$mw set charge -1.1128

topo retypebonds
topo retypeangles
topo writelammpsdata ${molname}.lmpsys

set sel [atomselect top all]
set mm [measure minmax $sel]
set xlo [format %.4f  [lindex $mm 0 0]]
set xhi [format %.4f  [lindex $mm 1 0]]
set ylo [format %.4f  [lindex $mm 0 1]]
set yhi [format %.4f  [lindex $mm 1 1]]
set zlo [format %.4f  [lindex $mm 0 2]]
set zhi [format %.4f  [lindex $mm 1 2]]

exec sed -i "12s/.*/  $xlo $xhi  xlo xhi/" ${molname}.lmpsys
exec sed -i "13s/.*/  $ylo $yhi  ylo yhi/" ${molname}.lmpsys
exec sed -i "14s/.*/  $zlo $zhi  zlo zhi/" ${molname}.lmpsys

mol delete all
exit

