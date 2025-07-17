#!/bin/bash
#FLUX: --job-name=hairy-plant-8149
#FLUX: -n=40
#FLUX: --queue=cpu
#FLUX: --urgency=16

module purge
module load gromacs/2019.4-gcc-9.2.0-openmpi
ulimit -s unlimited
ulimit -l unlimited
srun --mpi=pmi2 gmx_mpi mdrun -s ion_channel.tpr -maxh 0.50 -resethway -noconfout -nsteps 10000
