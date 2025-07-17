#!/bin/bash
#FLUX: --job-name=carnivorous-pedo-2222
#FLUX: --queue=gpu
#FLUX: -t=258900
#FLUX: --urgency=16

export SINGULARITYENV_MPLBACKEND='agg'

module purge
module load singularity tensorflow/1.12.0-py36
export SINGULARITYENV_MPLBACKEND="agg"
singularity-gpu exec /home/$USER/tensorflow-1.12.0-py36.simg python /home/$USER/swmm_rl/swmm_ddpg_multi_inp.py
