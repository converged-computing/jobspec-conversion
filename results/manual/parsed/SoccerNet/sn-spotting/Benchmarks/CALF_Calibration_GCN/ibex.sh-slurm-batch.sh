#!/bin/bash
#SBATCH --job-name=ASpot
#SBATCH --output=log/%x.%3a.%A.out
#SBATCH --error=log/%x.%3a.%A.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:v100:1
#SBATCH --mem=90G
#SBATCH --time=5-00:00:00
#SBATCH --exclude=gpu212-14

date
echo "Loading anaconda..."
module load anaconda3
module load cuda/10.1.243
module list
source activate CALF-pytorch
echo "...Anaconda env loaded"
echo "Running python script..."
python src/main.py \
--SoccerNet_path=/ibex/scratch/giancos/SoccerNet_calibration/ \
--features=ResNET_TF2_PCA512.npy \
--num_features=512 \
--model_name=CALF_subj_SBATCH \
--batch_size 32 \
--evaluation_frequency 20 \
--chunks_per_epoch 18000 \
"$@"
echo "... script terminated"
date
