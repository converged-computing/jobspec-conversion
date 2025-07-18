#!/bin/bash
#FLUX: --job-name=Deep-DAE_MLP_7_inc_real_RICA_relu
#FLUX: --queue=mono
#FLUX: -t=345600
#FLUX: --urgency=16

source /etc/profile.modules
module load gcc
module load matlab
cd ~/deepLearn && srun ./deepFunction 7 'DAE' 'MLP' '128   250   500  1000  2000   250    10' '0  0  0  0  0  0  0' '7_inc_real' 'RICA_relu' "'iteration.n_epochs', 'learning.lrate', 'use_tanh', 'noise.drop', 'noise.level', 'rica.cost', 'cae.cost'" '200 1e-3 2 0 0 0.1 0' "'iteration.n_epochs', 'use_tanh'" '200 2'
