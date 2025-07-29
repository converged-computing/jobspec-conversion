#!/bin/bash
#SBATCH --job-name=huggingface
#SBATCH --output=huggingface.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu
#SBATCH --mem=64GB
#SBATCH --time=00:10:00
#SBATCH --constraint=ntasks-per-node=1

module purge
if [ -e /dev/nvidia0 ]; then nv="--nv"; fi
singularity exec $nv \
  --overlay /scratch/mjd9571/singularity/overlay-50G-10M.ext3:rw \
  /scratch/work/public/singularity/cuda11.2.2-cudnn8-devel-ubuntu20.04.sif \
  /bin/bash -c "source /ext3/env.sh; python /scratch/mjd9571/huggingface.py"
