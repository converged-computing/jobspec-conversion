#!/bin/bash
#FLUX: --job-name=l2h00001
#FLUX: -c=10
#FLUX: --queue=gpu
#FLUX: -t=36000
#FLUX: --urgency=16

ml python/2.7.13
module load py-scipystack/1.0_py27 py-tensorflow/1.9.0_py27
srun python run_model_training_w_val.py --gres
