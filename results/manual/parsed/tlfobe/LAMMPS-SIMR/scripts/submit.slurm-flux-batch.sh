#!/bin/bash
#FLUX: --job-name=reclusive-kitty-5091
#FLUX: --queue=RM-shared
#FLUX: --priority=16

export lmp_mpi='/home/tfobe/Programs/lammps-22Aug18/src/lmp_mpi'

module load mpi/intel_mpi
export lmp_mpi=/home/tfobe/Programs/lammps-22Aug18/src/lmp_mpi
sleep 1 # possibly to give module to load?
echo "SUBMITTED" > jobstatus.txt
echo "RUNNING LAMMPS"
mpirun -n 4 $lmp_mpi -var tmp TEMP -var prs PRES -var poly POLY< LAMMPS.in  > LAMMPS.out
echo "FINISHED" > jobstatus.txt
echo "Job Ended at `date`"
