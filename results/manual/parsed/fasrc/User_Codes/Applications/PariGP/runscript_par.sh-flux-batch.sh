#!/bin/bash
#FLUX: --job-name=gloopy-cherry-5688
#FLUX: --urgency=16

module load gcc/12.2.0-fasrc01  openmpi/4.1.4-fasrc01 pari/2.15.4-fasrc02
srun -n $SLURM_NTASKS --mpi=pmix gp < par_pari.gp
