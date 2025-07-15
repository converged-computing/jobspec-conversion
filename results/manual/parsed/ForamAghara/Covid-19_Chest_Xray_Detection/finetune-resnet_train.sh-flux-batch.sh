#!/bin/bash
#FLUX: --job-name=resnet_train
#FLUX: -c=4
#FLUX: --queue=skylake-gpu
#FLUX: -t=23400
#FLUX: --urgency=16

module load openmpi/4.0.0
module load cudnn/7.6.5-cuda-10.2.89
source activate /home/mrajopad/.conda/envs/test
cd "/home/mrajopad/"
srun "/home/mrajopad/.conda/envs/test/bin/python3" "finetune-resnet_train.py"
