#!/bin/bash
#SBATCH --job-name=cifar10vit16
#SBATCH --output=myjobresults-%J.out
#SBATCH --error=myjobresults-%J.err
#SBATCH --mail-user=ta187904@ucf.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2
#SBATCH --time=1-06:00:00
#SBATCH --constraint=ntasks-per-node=4,gpu32

export LD_LIBRARY_PATH='/home/cap6411.student28/anaconda3/envs/env/lib'

echo "Slurm nodes assigned :$SLURM_JOB_NODELIST"
module purge
module load cuda
module load gcc/gcc-9.1.0
module load oneapi/mkl
source ~/.bashrc
conda activate vitenv
export LD_LIBRARY_PATH=/home/cap6411.student28/anaconda3/envs/env/lib
python cifar10vit16.py
