#!/bin/bash
#FLUX: --job-name=fat-leg-8327
#FLUX: -c=6
#FLUX: --queue=gpuk80
#FLUX: --priority=16

export SINGULARITY_HOME='$PWD:/home/$USER'

module load cuda/10.1
module load singularity
cd $HOME/data/ravi/spect-pitch-gan
singularity pull --name tf_1_12.simg shub://ravi-0841/singularity-tensorflow-1.14
export SINGULARITY_HOME=$PWD:/home/$USER
singularity exec --nv ./tf_1_12.simg python3 vae_encoder_decoder.py
