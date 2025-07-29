#!/bin/bash
#FLUX: --job-name=unet_train_1
#FLUX: --queue=gpuq
#FLUX: -t=480
#FLUX: --urgency=16

echo  "$(which singularity)"
singularity instance start --nv -B /home/mle35:/home/mle35,/scratch/mle35:/scratch/mle35  /home/mle35/rapidsai.sif rapids
cd /home/mle35/nga-deep-learning/scripts
singularity run instance://rapids python train.py 
