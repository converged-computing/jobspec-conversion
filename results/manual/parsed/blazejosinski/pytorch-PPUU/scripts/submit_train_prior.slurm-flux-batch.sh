#!/bin/bash
#FLUX: --job-name=train_prior
#FLUX: -t=172800
#FLUX: --priority=16

module load python-3.6
cd ../
srun python train_prior.py -nfeature $1 -n_mixture $2 -mfile $3
