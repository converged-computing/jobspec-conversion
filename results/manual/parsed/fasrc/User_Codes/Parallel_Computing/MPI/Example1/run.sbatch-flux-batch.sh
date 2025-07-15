#!/bin/bash
#FLUX: --job-name=purple-parrot-7167
#FLUX: --priority=16

module load intel/24.0.1-fasrc01 openmpi/5.0.2-fasrc01
srun -n $SLURM_NTASKS --mpi=pmix ./pi_monte_carlo.x
