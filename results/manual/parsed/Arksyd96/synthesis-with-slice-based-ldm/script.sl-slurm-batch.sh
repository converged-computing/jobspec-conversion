#!/bin/bash
#SBATCH --output=slurm/%J.out
#SBATCH --error=slurm/%J.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:4
#SBATCH --mem=50000
#SBATCH --time=3-00:00:00
#SBATCH --constraint=ntasks-per-node=4

export PYTHONUSERBASE='/home/2021012/sruan01/riles/env'

module load aidl/pytorch/1.11.0-cuda11.3
export PYTHONUSERBASE=/home/2021012/sruan01/riles/env
pip install pytorch-lightning --user
srun python3 $1
