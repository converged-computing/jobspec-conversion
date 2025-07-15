#!/bin/bash
#FLUX: --job-name=frigid-gato-7662
#FLUX: -c=6
#FLUX: -t=60
#FLUX: --urgency=16

module load python/3.6 scipy-stack
module load StdEnv/2020 gcc/9.3.0
module load rdkit/2021.03.3
source  ~/env/reinvent/bin/activate
time python train_prior.py --num-epochs 100 # --verbose
deactivate
