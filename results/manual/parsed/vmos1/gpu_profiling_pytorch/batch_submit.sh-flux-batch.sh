#!/bin/bash
#FLUX: --job-name=cnn_pytorch
#FLUX: -c=8
#FLUX: --gpus-per-task=1
#FLUX: -t=1200
#FLUX: --priority=16

echo "--start date" `date` `date +%s`
echo '--hostname ' $HOSTNAME
conda activate v3
module load nsight-systems
srun nsys profile --stats=true -t nvtx,cuda python pytorch_cnn.py -b 256 -e 10
echo "--end date" `date` `date +%s`
