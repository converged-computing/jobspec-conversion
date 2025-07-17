#!/bin/bash
#FLUX: --job-name=gpu_job
#FLUX: -n=32
#FLUX: --queue=gpuq
#FLUX: -t=431940
#FLUX: --urgency=16

set echo 
umask 0022 
nvidia-smi
module load gnu10
module load python
module load cudnn
module load nccl
for n in $(seq 5 5 3730)
do
        echo $n
        python evaluate.py --gpu_idx 0 --pretrained_path ../checkpoints/complexer_yolo/Model_complexer_yolo_epoch_${n}.pth --cfgfile ./config/cfg/complex_yolov3.cfg
done
