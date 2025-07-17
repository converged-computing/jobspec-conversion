#!/bin/bash
#FLUX: --job-name=train
#FLUX: -c=2
#FLUX: --queue=gpu
#FLUX: -t=604800
#FLUX: --urgency=16

module purge
module load Python cuDNN
source ~/myTensorflow/bin/activate
keras_retinanet/bin/train.py --gpu 2 --epochs 50 --weights /home/barimpac/keras-retinanet/snapshots/resubmit/resnet50_csv_34.h5 --snapshot-path /home/barimpac/keras-retinanet/snapshots/squares/ --steps 1473 csv DT_square_train.csv csv/class_mapping_multi.csv
