#!/bin/bash

density="800 850 900 950 990 995 1000 1005"

# Set the temperatures to run LAMMPS at
temperatures="300 400 500"

for d in $density 

do

# Loop through the temperatures
for temp in $temperatures
do
    # Run LAMMPS with the current temperature
    mpirun -np 4 lmp_mpi < water.lmp -var density $d -var temperature $temp
done
done 
