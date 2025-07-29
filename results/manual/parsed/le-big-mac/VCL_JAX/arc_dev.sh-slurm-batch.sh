#!/bin/bash
#SBATCH --job-name=vcl
#SBATCH --output=reports/%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=12G
#SBATCH --partition=devel
#SBATCH --constraint=ntasks-per-node=1

module load Anaconda3/2023.09-0
module use $DATA/easybuild/modules/all
module load CUDA/12.1.1
module load cuDNN/8.9.2.26-CUDA-12.1.1
source activate $DATA/.cache/conda/envs/vcl4
python run_$1.py $2
