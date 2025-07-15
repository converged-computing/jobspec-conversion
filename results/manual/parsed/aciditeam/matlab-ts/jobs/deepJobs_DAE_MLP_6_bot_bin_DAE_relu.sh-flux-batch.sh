#!/bin/bash
#FLUX: --job-name=wobbly-platanos-1229
#FLUX: --queue=mono
#FLUX: -t=345600
#FLUX: --priority=16

source /etc/profile.modules
module load gcc
module load matlab
cd ~/deepLearn && srun ./deepFunction 6 'DAE' 'MLP' '128   500  1500  1000  2000    10' '0  1  1  1  1  1' '6_bot_bin' 'DAE_relu' "'iteration.n_epochs', 'learning.lrate', 'use_tanh', 'noise.drop', 'noise.level', 'rica.cost', 'cae.cost'" '200 1e-3 2 0.1 0.1 0 0' "'iteration.n_epochs', 'use_tanh'" '200 2'
