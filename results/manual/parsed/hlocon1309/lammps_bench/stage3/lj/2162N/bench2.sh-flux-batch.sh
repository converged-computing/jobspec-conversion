#!/bin/bash
#FLUX: --job-name=arid-butter-2845
#FLUX: --priority=16

module load openmpi/4.1.4
module load CUDA/11.7
module load lammps/2022jun23_update1
srun --mpi=pmix_v2 lmp -i in.lj -sf gpu -pk gpu 2
