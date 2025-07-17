#!/bin/bash
#FLUX: --job-name=bloated-latke-1387
#FLUX: --queue=gpushort
#FLUX: -t=14400
#FLUX: --urgency=16

module load anaconda3
source activate /scratch/work/phama1/tensorflow
srun --gres=gpu:1 python train_frcnn.py -p VOCdevkit \
  --config_filename config_all_classes.pickle \
  --output_weight_path ./model_all_classes_2.hdf5 \
  --num_epochs 18 \
  --input_weight_path model_all_classes.hdf5 
