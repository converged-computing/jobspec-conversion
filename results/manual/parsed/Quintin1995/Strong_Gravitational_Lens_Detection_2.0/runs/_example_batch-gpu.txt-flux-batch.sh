#!/bin/bash
#FLUX: --job-name=angry-kitty-6251
#FLUX: --queue=gpu
#FLUX: -t=10800
#FLUX: --urgency=16

module load TensorFlow/2.1.0-fosscuda-2019b-Python-3.7.4
module load matplotlib/3.1.1-fosscuda-2019b-Python-3.7.4
module load scikit-image/0.16.2-fosscuda-2019b-Python-3.7.4
python3 main.py runs/experiment2_avg_pooling/run${SLURM_ARRAY_TASK_ID}.yaml
