#!/bin/bash
#FLUX: --job-name=crunchy-arm-3643
#FLUX: -t=1800
#FLUX: --priority=16

module load openmpi/4.1.4
module load CUDA/11.7
module load lammps/2022sep15_cpu
srun --mpi=pmix_v2 lmp -i in.eam
