#!/bin/bash
#FLUX: --job-name=dqn-hyperparams-sweep
#FLUX: -c=8
#FLUX: -t=86400
#FLUX: --priority=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK;'

module purge;
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK;
singularity exec --nv \
  --overlay /scratch/$USER/my_env/overlay-50G-10M.ext3:rw \
  /scratch/work/public/singularity/cuda11.8.86-cudnn8.7-devel-ubuntu22.04.2.sif \
  /bin/bash -c "source /ext3/env.sh; wandb agent fuzzy-enigma/dqn-sweep/${1}"
