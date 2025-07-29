#!/bin/bash
#SBATCH --account=rrg-dprecup
#SBATCH --output=logs/%N-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:1
#SBATCH --mem=10000M
#SBATCH --time=00:03:00

source ~/pytorch/bin/activate 
cd ~/OnExposureBias/
python "$@"
