#!/bin/bash
#FLUX: --job-name=test
#FLUX: -c=2
#FLUX: --queue=gpu
#FLUX: -t=600
#FLUX: --urgency=16

module purge
module load Python cuDNN
source ~/myTensorflow/bin/activate
keras_retinanet/bin/evaluate.py --save-path ~/results/squares csv test_annotation_multi.csv csv/class_mapping_multi.csv snapshots/squares/resnet50_csv_50.h5
