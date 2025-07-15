#!/bin/bash
#FLUX: --job-name=spicy-poo-0813
#FLUX: -c=6
#FLUX: -t=432000
#FLUX: --urgency=16

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
