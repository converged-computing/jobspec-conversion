#!/bin/bash
#FLUX: --job-name=G2
#FLUX: --queue=gpu
#FLUX: -t=1044000
#FLUX: --urgency=16

module load singularity
singularity instance start ../../../tensorflow/tensorflow-21.07-tf2-py3.sif tf2py3
cd "$PWD"
singularity exec instance://tf2py3 python model_eval_2.py
