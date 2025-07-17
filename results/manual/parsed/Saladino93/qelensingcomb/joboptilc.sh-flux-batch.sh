#!/bin/bash
#FLUX: --job-name=expensive-knife-2251
#FLUX: -N=3
#FLUX: -t=19200
#FLUX: --urgency=16

export DISABLE_MPI='false'
export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

cd $SLURM_SUBMIT_DIR
export DISABLE_MPI=false
module load autotools
module load intelmpi
module load intelpython3
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
srun python execute_opt.py configurations/configILC.yaml
