#!/bin/bash
#FLUX: --job-name=cdropfin7
#FLUX: -c=8
#FLUX: -t=3600
#FLUX: --urgency=16

module purge
module load anaconda3/2022.5
conda activate audit
wandb offline
epoch=50
I=0.7
experiment="COVIDx_dropout$I"
dataset="COVIDx"
for k in 0 10 20 30 40 50
do
    for fold in 0 1 2 3 4 5 6
    do
        echo k $k fold $fold
        python run_audit.py --k $k --fold $fold --audit EMA --epoch $epoch --cal_data $dataset --dataset $dataset --cal_size 10000 --expt $experiment --dropout $I
    done
done
