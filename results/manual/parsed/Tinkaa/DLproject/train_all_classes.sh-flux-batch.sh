#!/bin/bash
#FLUX: --job-name=faux-arm-8869
#FLUX: --priority=16

module load anaconda3
source activate /scratch/work/phama1/tensorflow
srun --gres=gpu:1 python train_frcnn.py -p VOCdevkit \
  --config_filename config_all_classes.pickle \
  --output_weight_path ./model_all_classes_2.hdf5 \
  --num_epochs 18 \
  --input_weight_path model_all_classes.hdf5 
