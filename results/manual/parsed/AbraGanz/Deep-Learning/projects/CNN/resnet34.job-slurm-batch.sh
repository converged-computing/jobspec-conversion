#!/bin/bash
#SBATCH --job-name=ExampleJob
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=3
#SBATCH --gres=gpu:1
#SBATCH --mem=32000M
#SBATCH --time=04:00:00
#SBATCH --partition=gpu_shared_course

SBATCH --output=resnet_34.out
module purge
module load 2021
module load Anaconda3/2021.05
cd $HOME/...
source activate dl2021
srun python -u main_cnn.py --model_name resnet34
