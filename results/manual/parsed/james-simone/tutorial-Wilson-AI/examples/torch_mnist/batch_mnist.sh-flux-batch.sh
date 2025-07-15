#!/bin/bash
#FLUX: --job-name=MNIST
#FLUX: -c=4
#FLUX: --queue=gpu_gce
#FLUX: -t=1800
#FLUX: --priority=16

export WCPROJECT='simone'
export CONT_DIR='/wclustre/${WCPROJECT}/containers/'

module load apptainer
export WCPROJECT=simone
export CONT_DIR=/wclustre/${WCPROJECT}/containers/
TORCH=${CONT_DIR}/pytorch-23.02-py3.sif
apptainer exec --home=/work1/${WCPROJECT} --nv ${TORCH} /usr/bin/nvidia-smi
apptainer exec --home=/work1/${WCPROJECT} --nv ${TORCH} /usr/bin/python ./mnist_main.py
