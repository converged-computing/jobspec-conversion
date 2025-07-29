#!/bin/bash
#FLUX --job-name=buttery-knife-7551
#FLUX --queue=normal
#FLUX -t=1800
#FLUX --urgency=16

module load openmpi/4.1.4
module load CUDA/11.7
module load lammps/2022sep15_cpu
srun --mpi=pmix_v2 lmp -i tip3p.lmp
