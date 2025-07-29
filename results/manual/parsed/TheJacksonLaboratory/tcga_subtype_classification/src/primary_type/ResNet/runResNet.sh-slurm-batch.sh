#!/bin/bash
#FLUX: --job-name=ResNet
#FLUX: -c=2
#FLUX: -t=360000
#FLUX: --urgency=16

alpha=0.01
dataSet=tumor_type
num_epochs=1000
batch_size=128
random_seed=1024
num_feature=254
nn_structure=200_128_32
dropout_keep_rate=${1}
treat=ResNet_DEG_Feature_1000_smote_orderChromo_Best
python ResNet/ExternalTest.py --data_set=tumor_type --treat=${treat}
