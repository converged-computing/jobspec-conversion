#!/bin/bash
#SBATCH --job-name=rerun_train_data
#SBATCH --output=rerun_train_data_%j.txt
#SBATCH --mail-user=lhan2@stanford.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=16000
#SBATCH --time=08:00:00

export OPENCV_OPENCL_RUNTIME=''

module load tensorflow
export OPENCV_OPENCL_RUNTIME=
python rerun_train_data.py
