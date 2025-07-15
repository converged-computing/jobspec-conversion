#!/bin/bash
#FLUX: --job-name=DCGAN
#FLUX: --queue=gpu
#FLUX: -t=72000
#FLUX: --urgency=16

source /data/$USER/.envs/pyenv37/bin/activate
module load Python/3.7.4-GCCcore-8.3.0 
module load TensorFlow/2.1.0-fosscuda-2019b-Python-3.7.4
echo Starting Python program
python /data/s3972445/.envs/pyenv37/dreaming-rl/DCGAN.py
