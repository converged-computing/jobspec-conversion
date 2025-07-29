#!/bin/bash
#SBATCH --job-name=emnlp_baseline
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=200GB
#SBATCH --time=3-00:00:00
#SBATCH --constraint=ntasks-per-node=1

echo "loading"
module load python/3.6.1
module load cudnn/v6
module load cuda/8.0.61
module load tensorflow/1.5.0-py36-gpu
echo "loaded"
python learn.py --num $1 --stage1 $2 --dn $3 --casing $4
