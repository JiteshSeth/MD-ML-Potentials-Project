puts "usage: dipoleMoment psf dcd timeStep(fs) dcdFreq filename (optional)"

proc dipoleMoment {psfPrefix dcdPrefix timeStep dcdFreq {fname "dipole.dat"} } {
  
mol load psf $psfPrefix.psf
mol addfile $dcdPrefix.dcd waitfor all

set nframe [molinfo top get numframes]
puts "frames:$nframe"
set dt [expr $timeStep*$dcdFreq*0.001]; # time in ps 

set fp [open $fname "w"]

    for {set i 0} {$i < $nframe} {incr i} {

        molinfo top set frame $i
        set sel [atomselect top water]
        set dpm [measure dipole $sel -debye]
        $sel delete

        set dpx [lindex $dpm 0]
        set dpy [lindex $dpm 1]
        set dpz [lindex $dpm 2]
        set dpt [expr sqrt($dpx*$dpx+$dpy*$dpy+$dpz*$dpz)]
        set t [expr $dt*$i]

        puts $fp [format "%.4f \t %.4f \t %.4f \t %.4f \t %.4f" $t $dpx $dpy $dpz $dpt]
        puts [format "%.4f \t %.4f \t %.4f \t %.4f \t %.4f" $t $dpx $dpy $dpz $dpt]
    }

close $fp
}
