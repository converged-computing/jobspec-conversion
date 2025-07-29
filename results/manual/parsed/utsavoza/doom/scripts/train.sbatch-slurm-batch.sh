#!/bin/bash
#SBATCH --job-name=dqn-hyperparams-sweep
#SBATCH --account=class
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=96GB
#SBATCH --time=1-00:00:00
#SBATCH --qos=4294967293
#SBATCH --constraint=ntasks-per-node=1

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK;'

module purge;
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK;
singularity exec --nv \
  --overlay /scratch/$USER/my_env/overlay-50G-10M.ext3:rw \
  /scratch/work/public/singularity/cuda11.8.86-cudnn8.7-devel-ubuntu22.04.2.sif \
  /bin/bash -c "source /ext3/env.sh; python main.py"
