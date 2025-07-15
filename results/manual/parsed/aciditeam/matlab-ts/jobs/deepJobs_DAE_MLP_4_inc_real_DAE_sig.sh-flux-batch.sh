#!/bin/bash
#FLUX: --job-name=grated-signal-2128
#FLUX: --queue=mono
#FLUX: -t=345600
#FLUX: --priority=16

source /etc/profile.modules
module load gcc
module load matlab
cd ~/deepLearn && srun ./deepFunction 4 'DAE' 'MLP' '128  1000  1500    10' '0  0  0  0' '4_inc_real' 'DAE_sig' "'iteration.n_epochs', 'learning.lrate', 'use_tanh', 'noise.drop', 'noise.level', 'rica.cost', 'cae.cost'" '200 1e-3 0 0.1 0.1 0 0' "'iteration.n_epochs', 'use_tanh'" '200 0'
