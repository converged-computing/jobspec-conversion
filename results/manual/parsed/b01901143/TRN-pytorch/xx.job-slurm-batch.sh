#!/bin/bash
#SBATCH --job-name=test_model
#SBATCH --output=stdout.%j
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2
#SBATCH --mem-per-cpu=10240M
#SBATCH --time=15:00:00
#SBATCH --partition=gpu

cd /scratch/user/kevin83427/TRN-pytorch
module load Anaconda/3-5.0.0.1
source activate pytorch
./test_moment.sh
