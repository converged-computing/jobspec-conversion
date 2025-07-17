#!/bin/bash
#FLUX: --job-name=joyous-hope-3303
#FLUX: -t=86340
#FLUX: --urgency=16

module load daint-gpu
module load cray-python
module load TensorFlow/1.14.0-CrayGNU-19.10-cuda-10.1.168-python3
source $HOME/default/bin/activate
cd $HOME/gan_audio_inpainting/code/experiments
srun python myexperiments-extend-solo.py
