#!/bin/bash
#FLUX: --job-name=swampy-parsnip-3790
#FLUX: --exclusive
#FLUX: -t=120
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

echo $SLURM_JOB_NODELIST
nodeset -e $SLURM_JOB_NODELIST
cd $SLURM_SUBMIT_DIR
module load intel_psxe/2019
EXEC1=/scratch/padinpe/____/stream
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
echo "SLURM_CPUS_PER_TASK" $SLURM_CPUS_PER_TASK
srun -N 1 -c $SLURM_CPUS_PER_TASK $EXEC1
