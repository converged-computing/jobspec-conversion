#!/bin/bash
#FLUX: --job-name=myImageLoader
#FLUX: -t=86400
#FLUX: --urgency=16

module purge
module load python3/intel/3.5.3
module load pytorch/python3.5/0.2.0_3
source ~/scripts/deep_learning_hw2/dl_env/bin/activate
python model_loader.py
