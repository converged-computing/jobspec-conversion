#!/bin/bash
#FLUX: --job-name=fat-plant-5913
#FLUX: --queue=gpu
#FLUX: -t=108000
#FLUX: --urgency=16

module load anaconda3
source activate /scratch/work/phama1/tensorflow
srun --gres=gpu:1 python train_frcnn.py -p VOCdevkit --input_weight_path model_frcnn_3_classes.hdf5
