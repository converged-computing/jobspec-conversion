#!/bin/bash
#SBATCH --job-name=weather-gan
#SBATCH --account=tipes
#SBATCH --output=out/%x-%j.out
#SBATCH --error=out/%x-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:v100:1
#SBATCH --mem=64GB
#SBATCH --qos=medium

module load singularity
source /p/system/packages/spack/share/spack/setup-env.sh
spack load squashfs@4.4%gcc@8.3.0
mkdir -p /tmp/singularity/mnt/session
cd /home/hess/projects/weather-gan/
singularity run --nv --bind /p /home/hess/projects/container/singularity-pytorch/stack_v4.sif python main.py
