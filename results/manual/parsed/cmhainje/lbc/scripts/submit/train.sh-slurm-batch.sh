#!/bin/bash
#SBATCH --job-name=train
#SBATCH --output=slurm-%x-%A_%a.out
#SBATCH --error=slurm-%x-%A_%a.out
#SBATCH --mail-user=ch4407@nyu.edu
#SBATCH --mail-type=all
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu
#SBATCH --mem=10GB
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=1,2,4,8,16,32,64

module purge
singularity exec --nv \
    --overlay /home/ch4407/py/overlay-15GB-500K.ext3:ro \
    /scratch/work/public/singularity/cuda11.8.86-cudnn8.7-devel-ubuntu22.04.2.sif* \
    /bin/bash -c \
    "source /ext3/env.sh; venv lbc; cd /home/ch4407/lbc/scripts; \
    python train.py 100_000 -c 4 -l $SLURM_ARRAY_TASK_ID --camera r; \
    python train.py 100_000 -c 4 -l $SLURM_ARRAY_TASK_ID --camera b;"
