#!/bin/bash
#FLUX: --job-name=conspicuous-itch-8882
#FLUX: --queue=train
#FLUX: -t=1209600
#FLUX: --urgency=16

for batch in 1024 2048 4096 8192
do
     python main.py --log_file main_log2.txt --epochs 5 --world-size 8 --rank 0 --workers 64 --batch-size $batch
done
for batch in 512 1024 2048
do
     python main.py --arch resnet50 --log_file main_log2.txt --epochs 5 --world-size 8 --rank 0 --workers 64 --batch-size $batch
done
