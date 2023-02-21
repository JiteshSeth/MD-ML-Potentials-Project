temperatures="300 400 500"

for temp in $temperatures
do
    # Run LAMMPS with the current temperature
    mpirun -np 4 lmp_mpi -in water.lmp -var temperature $temp
done
