#!/bin/bash
#FLUX: --job-name=Deep-DAE_SDAE_6_dec_real_CAE_tanh
#FLUX: --queue=mono
#FLUX: -t=345600
#FLUX: --urgency=16

source /etc/profile.modules
module load gcc
module load matlab
cd ~/deepLearn && srun ./deepFunction 6 'DAE' 'SDAE' '128  2000  1500  1000   500    10' '0  0  0  0  0  0' '6_dec_real' 'CAE_tanh' "'iteration.n_epochs', 'learning.lrate', 'use_tanh', 'noise.drop', 'noise.level', 'rica.cost', 'cae.cost'" '200 1e-3 1 0 0 0.01 0' "'iteration.n_epochs', 'use_tanh'" '200 1'
