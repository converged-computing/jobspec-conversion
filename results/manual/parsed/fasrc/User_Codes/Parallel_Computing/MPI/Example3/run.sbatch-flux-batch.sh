#!/bin/bash
#FLUX: --job-name=planczos
#FLUX: -n=8
#FLUX: --queue=test
#FLUX: -t=1800
#FLUX: --urgency=16

module load intel/24.0.1-fasrc01 openmpi/5.0.2-fasrc01
srun -n $SLURM_NTASKS --mpi=pmix ./planczos.x
