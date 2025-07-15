#!/bin/bash
#FLUX: --job-name=faux-leader-3658
#FLUX: --queue=mono
#FLUX: -t=345600
#FLUX: --priority=16

source /etc/profile.modules
module load gcc
module load matlab
cd ~/deepLearn && srun ./deepFunction 4 'DAE' 'MLP' '128  1500  1500    10' '0  1  1  1' '4_lin_bin' 'DAE_relu' "'iteration.n_epochs', 'learning.lrate', 'use_tanh', 'noise.drop', 'noise.level', 'rica.cost', 'cae.cost'" '200 1e-3 2 0.1 0.1 0 0' "'iteration.n_epochs', 'use_tanh'" '200 2'
