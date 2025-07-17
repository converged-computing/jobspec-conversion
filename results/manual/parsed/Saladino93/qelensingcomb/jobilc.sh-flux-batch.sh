#!/bin/bash
#FLUX: --job-name=misunderstood-soup-8441
#FLUX: -N=24
#FLUX: -t=51000
#FLUX: --urgency=16

export DISABLE_MPI='false'
export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

cd $SLURM_SUBMIT_DIR
export DISABLE_MPI=false
module load autotools
module load intelmpi
module load intelpython3
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
srun python extract_biases.py configurations/configILC.yaml
