#!/bin/bash
#FLUX: --job-name=mpi4py-test
#FLUX: -n=4
#FLUX: -t=60
#FLUX: --urgency=16

module purge
module load anaconda3/2022.5 openmpi/gcc/<x.y.z>  # REPLACE <x.y.z>
conda activate fast-mpi4py
srun python hello_mpi.py
