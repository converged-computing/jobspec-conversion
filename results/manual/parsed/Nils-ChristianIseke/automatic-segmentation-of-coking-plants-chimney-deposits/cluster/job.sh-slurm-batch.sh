#!/bin/bash
#SBATCH --job-name=nnUnet_job
#SBATCH --output=output_job
#SBATCH --error=error_job
#SBATCH --mail-user=nilsmailiseke@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --time=00:30:00

. setup_paths.sh
. preprocess.sh
. resume_training.sh
. start_multi_gpu_training_2d.sh
