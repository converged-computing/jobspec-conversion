#!/bin/bash
#FLUX: --job-name=delicious-frito-2152
#FLUX: -N=4
#FLUX: -n=16
#FLUX: --queue=normal
#FLUX: --urgency=16

module load openmpi/4.1.4
module load CUDA/11.7
module load lammps/2022jun23_update1
srun --mpi=pmix_v2 lmp -i in.lj -sf gpu -pk gpu 1
