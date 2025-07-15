#!/bin/bash
#FLUX: --job-name=gassy-kitty-4421
#FLUX: --queue=mono
#FLUX: -t=345600
#FLUX: --priority=16

source /etc/profile.modules
module load gcc
module load matlab
cd ~/deepLearn && srun ./deepFunction 5 'DAE' 'MLP' '128   500  1000  1500    10' '0  1  1  1  1' '5_inc_bin' 'CAE_relu' "'iteration.n_epochs', 'learning.lrate', 'use_tanh', 'noise.drop', 'noise.level', 'rica.cost', 'cae.cost'" '200 1e-3 2 0 0 0.01 0' "'iteration.n_epochs', 'use_tanh'" '200 2'
