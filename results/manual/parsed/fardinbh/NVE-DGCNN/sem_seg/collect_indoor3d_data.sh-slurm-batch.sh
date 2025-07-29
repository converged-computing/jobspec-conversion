#!/bin/bash
#SBATCH --output=collect-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --gres=gpu:1
#SBATCH --mem=123G
#SBATCH --time=00:10:00

module load cuda cudnn python/3.6
source ~/tensorflow/bin/activate
module load cuda
python ./collect_indoor3d_data.py
