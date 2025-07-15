#!/bin/bash
#FLUX: --job-name=f1_softloss_single_double
#FLUX: --queue=gpu
#FLUX: -t=28800
#FLUX: --priority=16

module load TensorFlow/2.1.0-fosscuda-2019b-Python-3.7.4
module load matplotlib/3.1.1-fosscuda-2019b-Python-3.7.4
module load scikit-image/0.16.2-fosscuda-2019b-Python-3.7.4
python3 main.py --run=runs/experiment8_f1_softloss/run${SLURM_ARRAY_TASK_ID}.yaml
