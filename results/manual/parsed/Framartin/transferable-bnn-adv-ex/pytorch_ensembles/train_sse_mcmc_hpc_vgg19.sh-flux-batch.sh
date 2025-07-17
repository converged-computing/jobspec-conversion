#!/bin/bash
#FLUX: --job-name=TrainVGG19
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=32400
#FLUX: --urgency=16

command -v module >/dev/null 2>&1 && module load lang/Python
source ../venv/bin/activate
set -x
bash ./train_sse_mcmc.sh CIFAR10 VGG19BN 1 ../models ../data cSGLD
