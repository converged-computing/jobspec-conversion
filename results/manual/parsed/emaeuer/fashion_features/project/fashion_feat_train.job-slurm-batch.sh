#!/bin/bash
#SBATCH --job-name=fashion_feat_train
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:v100:4
#SBATCH --mem=30G
#SBATCH --time=10:00:00
#SBATCH --partition=clara-job
#SBATCH --constraint=ntasks-per-node=1

export TF_CPP_MIN_LOG_LEVEL='2'

module load Python/3.7.4-GCCcore-8.3.0
module load CUDA/10.1.243-GCC-8.3.0
module load TensorFlow/2.2.0-fosscuda-2019b-Python-3.7.4
export TF_CPP_MIN_LOG_LEVEL=2
cd fashion_features/project
source env/bin/activate
srun python main.py --train
