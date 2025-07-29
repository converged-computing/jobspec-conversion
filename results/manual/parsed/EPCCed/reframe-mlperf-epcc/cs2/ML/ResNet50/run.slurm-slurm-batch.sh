#!/bin/bash
#FLUX: --job-name=mlperf-ResNet
#FLUX: -c=16
#FLUX: -t=43200
#FLUX: --urgency=16

source /home/z043/z043/crae-cs1/mlperf_cs2_pt/bin/activate
python /home/z043/z043/crae-cs1/chris-ml-intern/cs2/ML/ResNet50/train.py
