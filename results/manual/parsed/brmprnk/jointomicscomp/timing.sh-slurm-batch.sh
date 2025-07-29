#!/bin/bash
#SBATCH --job-name=timer
#SBATCH --mail-user=stavrosmakrodi
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:1
#SBATCH --mem=200000
#SBATCH --time=07:59:59
#SBATCH --qos=medium

ml use /opt/insy/modulefiles;
ml load cuda/11.0;
ml load cudnn/11.0-8.0.3.33;
python src/util/timer.py;
