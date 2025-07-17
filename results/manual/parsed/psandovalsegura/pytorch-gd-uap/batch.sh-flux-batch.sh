#!/bin/bash
#FLUX: --job-name=placid-soup-2753
#FLUX: --queue=dpart
#FLUX: -t=12600
#FLUX: --urgency=16

export WORK_DIR='/cfarhomes/psando/Documents/UAPs/gd-uap-pytorch/'

set -x
export WORK_DIR="/cfarhomes/psando/Documents/UAPs/gd-uap-pytorch/"
srun bash -c "cd ${WORK_DIR} && python3 train.py --model vgg16"
