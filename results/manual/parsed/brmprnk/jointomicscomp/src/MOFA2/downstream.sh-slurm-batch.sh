#!/bin/bash
#SBATCH --job-name=trainJoint
#SBATCH --mail-user=stavrosmakrodi
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=64000
#SBATCH --time=02:00:00
#SBATCH --partition=general
#SBATCH --qos=short

ml use /opt/insy/modulefiles;
ml load cuda/11.0;
ml load cudnn/11.0-8.0.3.33;
python src/MOFA2/downstream.py $@;
