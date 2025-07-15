#!/bin/bash
#FLUX: --job-name=peachy-hope-8125
#FLUX: --urgency=16

module load anaconda3
source activate /scratch/work/phama1/tensorflow
srun --gres=gpu:1 python train_frcnn.py -p VOCdevkit --input_weight_path model_frcnn_3_classes.hdf5
