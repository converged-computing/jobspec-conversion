#!/bin/bash
#FLUX: --job-name=psycho-animal-4483
#FLUX: --priority=16

module load anaconda3
source activate /scratch/work/phama1/tensorflow
srun --gres=gpu:1 python train_frcnn.py -p VOCdevkit --input_weight_path model_frcnn_3_classes.hdf5
