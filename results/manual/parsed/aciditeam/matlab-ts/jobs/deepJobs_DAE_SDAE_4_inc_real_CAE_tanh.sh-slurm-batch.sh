#!/bin/bash
#FLUX: --job-name=Deep-DAE_SDAE_4_inc_real_CAE_tanh
#FLUX: --queue=mono
#FLUX: -t=345600
#FLUX: --urgency=16

source /etc/profile.modules
module load gcc
module load matlab
cd ~/deepLearn && srun ./deepFunction 4 'DAE' 'SDAE' '128  1000  1500    10' '0  0  0  0' '4_inc_real' 'CAE_tanh' "'iteration.n_epochs', 'learning.lrate', 'use_tanh', 'noise.drop', 'noise.level', 'rica.cost', 'cae.cost'" '200 1e-3 1 0 0 0.01 0' "'iteration.n_epochs', 'use_tanh'" '200 1'
