#!/bin/bash
#SBATCH --job-name=OpenFold2Train
#SBATCH --output=/home/g.derevyanko/Logs/OpenFold2/Train/OpenFold2Train_%j.log
#SBATCH --nodes=6
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:4
#SBATCH --mem=64G
#SBATCH --time=3-00:00:00
#SBATCH --partition=gpu
#SBATCH --constraint=ntasks-per-node=4

export NCCL_DEBUG='INFO'
export PYTHONFAULTHANDLER='1'

module load gpu/cuda-11.3
module load compilers/gcc-8.3.0
conda activate torch
export NCCL_DEBUG=INFO
export PYTHONFAULTHANDLER=1
srun python training.py \
-dataset_dir /gpfs/gpfs0/g.derevyanko/OpenFold2Dataset/Features \
-log_dir TrainLog \
-model_name model_small \
-num_gpus 4 \
-num_nodes 6 \
-num_accum 3 \
-max_iter 1500000 \
-precision bf16 \
-progress_bar 0 #\
