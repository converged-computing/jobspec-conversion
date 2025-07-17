#!/bin/bash
#FLUX: --job-name=purple-staircase-2948
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=21600
#FLUX: --urgency=16

module load gcc/6.2.0
module load cuda/10.0
echo "#---------"
echo $CUDA_VISIBLE_DEVICES
nvidia-smi
nvidia-smi |grep "|\    [$CUDA_VISIBLE_DEVICES] "|awk '{print $3}'|xargs -r ps -o pid,ppid,uid -p
echo "#----------"
~/nvida_samples/1_Utilities/deviceQuery/deviceQuery
