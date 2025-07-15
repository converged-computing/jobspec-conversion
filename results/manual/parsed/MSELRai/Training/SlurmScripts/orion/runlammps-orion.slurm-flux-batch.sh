#!/bin/bash
#FLUX: --job-name=Ar
#FLUX: --exclusive
#FLUX: --queue=400p48h
#FLUX: -t=3600
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'

ulimit -s unlimited
export OMP_NUM_THREADS=1
echo "SLURM_NTASKS: " $SLURM_NTASKS
module purge
module load intel/2021.2
module load impi/2021.2
module load contrib
module load lammps-msel/29Sep2021
date 
echo "My LAMMPS Simulation"
srun lmp -in in.lammps
date
