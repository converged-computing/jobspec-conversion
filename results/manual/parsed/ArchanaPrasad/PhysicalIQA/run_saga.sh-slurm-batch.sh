#!/bin/bash
#SBATCH --account=mics
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gpus-per-task=1
#SBATCH --mem=4g
#SBATCH --time=20:00:00

source ~/.bashrc
conda activate ai2
. /scratch/spack/share/spack/setup-env.sh
spack load cuda@9.0.176
spack load cudnn@7.6.5.32-9.0-linux-x64
python train.py
