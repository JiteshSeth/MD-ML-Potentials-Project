package require psfgen

# Types in wat.pdb; OT and HT
# Names in wat.pdb; OH2 H1 H2
# Segname in wat.pdb; TIPS3P
# Resname in wat.pdb; TIP3
#
set pkmlOutput "Water_output"
set molname "waters"

mol load pdb ${pkmlOutput}.pdb
set sel [atomselect top "type OH 1HH 2HH"]
$sel set segname SPCE
$sel set resname SPC

set sel [atomselect top "type OH"]
$sel set type OT
$sel set name OH2
set sel [atomselect top "type 1HH"]
$sel set type HT
$sel set name H1
set sel [atomselect top "type 2HH"]
$sel set type HT
$sel set name H2

set sel [atomselect top "type HT OT"]
$sel writepdb waters.pdb

resetpsf
mol delete all

topology wat.top
segment SPC {pdb waters.pdb}
coordpdb waters.pdb SPC
writepsf waters.psf
writepdb waters.pdb

set molname "waters"

mol load psf ${molname}.psf pdb ${molname}.pdb

set hyd [atomselect top "type HT"]
$hyd set type 1HT
$hyd set charge 0.410
set oxy [atomselect top "type OT"]
$oxy set type 2OT
$oxy set charge -0.820

topo writelammpsdata water.lmpsys

set sel [atomselect top all]
set mm [measure minmax $sel]
set xlo [format %.4f  [lindex $mm 0 0]]
set xhi [format %.4f  [lindex $mm 1 0]]
set ylo [format %.4f  [lindex $mm 0 1]]
set yhi [format %.4f  [lindex $mm 1 1]]
set zlo [format %.4f  [lindex $mm 0 2]]
set zhi [format %.4f  [lindex $mm 1 2]]

exec sed -i "12s/.*/  $xlo $xhi  xlo xhi/" water.lmpsys
exec sed -i "13s/.*/  $ylo $yhi  ylo yhi/" water.lmpsys
exec sed -i "14s/.*/  $zlo $zhi  zlo zhi/" water.lmpsys

mol delete all
exit

