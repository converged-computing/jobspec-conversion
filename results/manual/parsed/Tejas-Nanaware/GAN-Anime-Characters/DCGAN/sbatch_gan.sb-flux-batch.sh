#!/bin/bash
#FLUX: --job-name=gan_anime
#FLUX: -N=2
#FLUX: --queue=gpu
#FLUX: -t=7200
#FLUX: --urgency=16

module load singularity # load the singularity module
singularity exec --nv /share/apps/gpu/singularity/images/keras/keras-v2.2.4-tensorflow-v1.12-gpu-20190214.simg python3 DCGAN.py
