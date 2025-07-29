#!/bin/bash
#SBATCH --job-name=crack_detection
#SBATCH --output=./OUTPUT/crack_detection.%J.out
#SBATCH --error=./OUTPUT/crack_detection.%J.err
#SBATCH --mail-user=yongxiang.shi@kaust.edu.sa
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=80GB
#SBATCH --time=02:00:00
#SBATCH --partition=batch

module load tensorflow/1.13.1-cuda10.0-cudnn7.6-py3.6
module load keras/2.2.4-cuda10.0-cudnn7.6-py3.6
module load anaconda3/4.4.0
python trainCNN.py
