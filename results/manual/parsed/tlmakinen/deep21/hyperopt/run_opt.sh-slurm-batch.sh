#!/bin/bash
#SBATCH --job-name=hypopt
#SBATCH --output=hyp_%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:v100-32gb:1
#SBATCH --mem=250gb
#SBATCH --time=15:00:00
#SBATCH --partition=gpu
#SBATCH --array=1-20

module load  gcc/7.4.0 cuda/10.1.243_418.87.00 cudnn/v7.6.2-cuda-10.1 nccl/2.4.2-cuda-10.1 python3/3.7.3
source ~/anaconda3/bin/activate tf_gpu
python3 hyperopt_script.py
