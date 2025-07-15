#!/bin/bash
#FLUX: --job-name=lovely-truffle-2046
#FLUX: --urgency=16

module load intel/24.0.1-fasrc01 openmpi/5.0.2-fasrc01
srun -n $SLURM_NTASKS --mpi=pmix ./planczos.x
