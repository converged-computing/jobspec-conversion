#!/bin/bash
#FLUX: --job-name=TrainLDAMP
#FLUX: -c=4
#FLUX: -t=86400
#FLUX: --priority=16

module purge; 
module load anaconda3/2020.07
module load cuda/11.6.2
module load cudnn/8.6.0.163-cuda11
source imageenv/bin/activate
python -u TrainLDAMP.py --data_path "/scratch/nm4074/imageprocessing/D-AMP_Toolbox/LDAMP_TensorFlow/TrainingData" --model_path "/scratch/nm4074/imageprocessing/D-AMP_Toolbox/LDAMP_TensorFlow/saved_models/LDAMP"
