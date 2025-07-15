#!/bin/bash
#FLUX: --job-name=strawberry-parsnip-7141
#FLUX: --queue=gpu
#FLUX: -t=61200
#FLUX: --urgency=16

command -v module >/dev/null 2>&1 && module load lang/Python
source ../venv/bin/activate
set -x
bash ./train_sse_mcmc.sh CIFAR10 resnet50 1 ../models ../data cSGLD
