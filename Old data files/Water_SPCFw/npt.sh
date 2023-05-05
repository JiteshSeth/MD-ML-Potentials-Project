temperatures="300 400 500"

for irun in 10 11 
do 
	for temp in $temperatures
	do
	    # Run LAMMPS with the current temperature
	    mpirun -np 1 lmp_gpu -pk gpu 1 -in water.lmp -var irun ${irun} -var temperature $temp
	done
done
