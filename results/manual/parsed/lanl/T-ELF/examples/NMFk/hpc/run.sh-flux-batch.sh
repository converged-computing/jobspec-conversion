#!/bin/bash
#FLUX: --job-name=boopy-banana-6085
#FLUX: -N=2
#FLUX: -c=120
#FLUX: -t=1800
#FLUX: --urgency=16

export PMIX_MCA_gds='hash'
export n_jobs='$SLURM_CPUS_PER_TASK'

export PMIX_MCA_gds=hash
source activate TELF
echo $CONDA_DEFAULT_ENV
export n_jobs=$SLURM_CPUS_PER_TASK
export PMIX_MCA_gds=hash
mpirun -n 2 python example.py 
