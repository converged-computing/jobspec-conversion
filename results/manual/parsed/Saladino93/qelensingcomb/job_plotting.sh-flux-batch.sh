#!/bin/bash
#FLUX: --job-name=stanky-train-2053
#FLUX: -N=12
#FLUX: -t=6000
#FLUX: --urgency=16

export DISABLE_MPI='false'
export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

cd $SLURM_SUBMIT_DIR
export DISABLE_MPI=false
module load autotools
module load intelmpi
module load intelpython3
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
srun python extract_biases.py configurations/config_plotting.yaml  
