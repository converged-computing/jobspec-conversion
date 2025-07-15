#!/bin/bash
#FLUX: --job-name=training
#FLUX: -t=345600
#FLUX: --priority=16

cd /home/yhh303/AI-writer_Data2Doc/train/
module load pytorch/python3.6/0.3.0_4
python3 -u train.py -embed 600 -lr 0.01 -batch 1 -getloss 20 -encoder HierarchicalRNN -decoder HierarchicalRNN -epochsave 5 -copy True -copyplayer True -gradclip 5 -layer 2 -epoch 10
