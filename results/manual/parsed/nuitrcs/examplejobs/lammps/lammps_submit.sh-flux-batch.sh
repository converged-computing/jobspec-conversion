#!/bin/bash
#FLUX: --job-name=lammps_openmpi
#FLUX: -N=2
#FLUX: --queue=short
#FLUX: -t=1200
#FLUX: --urgency=16

module purge
module load lammps/20200303-openmpi-4.0.5-intel-19.0.5.281
mpirun -np ${SLURM_NTASKS} lmp -in in.lj
