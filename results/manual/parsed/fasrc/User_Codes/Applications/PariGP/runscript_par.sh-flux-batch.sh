#!/bin/bash
#FLUX: --job-name=tart-omelette-1700
#FLUX: --priority=16

module load gcc/12.2.0-fasrc01  openmpi/4.1.4-fasrc01 pari/2.15.4-fasrc02
srun -n $SLURM_NTASKS --mpi=pmix gp < par_pari.gp
