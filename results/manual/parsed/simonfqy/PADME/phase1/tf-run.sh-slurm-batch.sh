#!/bin/bash
#SBATCH --output=logdnn.out
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:2
#SBATCH --mem-per-cpu=12G
#SBATCH --time=00:00:19

module load cuda cudnn python/3.5.2
source tensorflow/bin/activate
python3 SimBoost/xgboost/DNN_est.py
