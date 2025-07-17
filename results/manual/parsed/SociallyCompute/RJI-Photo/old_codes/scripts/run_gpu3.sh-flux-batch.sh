#!/bin/bash
#FLUX: --job-name=resnet_train
#FLUX: --queue=gpu3
#FLUX: -t=87780
#FLUX: --urgency=16

echo "### Starting at: $(date) ###"
modelname='October17_ava_30ep_MINI512_resnet_adam_regression'
dataset='ava'
epochs='30'
batch='512'
architecture='resnet'
subject='quality'
freeze='freeze'
lr='0.1'
mo='0.9'
optimizer='adam'
classification='False'
testflag='0'
python ../background_tasks/model_builder.py $modelname $dataset $epochs $batch $architecture $subject $freeze $lr $mo $optimizer $classification $testflag
echo "### Ending at: $(date) ###"
