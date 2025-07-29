#!/bin/bash
#SBATCH --job-name=creativeAI-image2emotionClassifier
#SBATCH --output=creativeAI_st_%j_out.txt
#SBATCH --error=creativeAI_st_%j_err.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:1
#SBATCH --mem=50GB
#SBATCH --time=1-00:00:00
#SBATCH --partition=cuda

ml purge
ml nvidia/cudasdk/10.1
ml intel/python/3/2019.4.088
cd /home/mtesta/creativeAI/imageSide
python3 main.py
srun --partition=cuda --nodes=1 --tasks-per-node=1 --gres=gpu:1 --time=06:00:00 --pty /bin/bash
