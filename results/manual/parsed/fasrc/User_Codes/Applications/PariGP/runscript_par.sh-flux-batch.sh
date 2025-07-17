#!/bin/bash
#FLUX: --job-name=par_pari
#FLUX: -N=2
#FLUX: -n=16
#FLUX: --queue=test
#FLUX: -t=1800
#FLUX: --urgency=16

module load gcc/12.2.0-fasrc01  openmpi/4.1.4-fasrc01 pari/2.15.4-fasrc02
srun -n $SLURM_NTASKS --mpi=pmix gp < par_pari.gp
