package require psfgen

# Types in wat.pdb; OT and HT
# Names in wat.pdb; OH2 H1 H2
# Segname in wat.pdb; TIPS3P
# Resname in wat.pdb; TIP3

#set molname1 "waterxNa"
#set molname2 "waterNa"

mol load pdb Water_output.pdb
set sel [atomselect top "type OH 1HH 2HH"]
$sel set segname TIPS3P
$sel set resname TIP3

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
segment TIP {pdb waters.pdb}
coordpdb waters.pdb TIP
writepsf waters.psf
writepdb waters.pdb



exit
