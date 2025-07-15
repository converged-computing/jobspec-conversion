#!/bin/bash
#FLUX: --job-name=fat-poodle-6961
#FLUX: --queue=mono
#FLUX: -t=345600
#FLUX: --priority=16

source /etc/profile.modules
module load gcc
module load matlab
cd ~/deepLearn && srun ./deepFunction 6 'DAE' 'SDAE' '128   500  1000  1500  2000    10' '0  0  0  0  0  0' '6_inc_real' 'DAE_relu' "'iteration.n_epochs', 'learning.lrate', 'use_tanh', 'noise.drop', 'noise.level', 'rica.cost', 'cae.cost'" '200 1e-3 2 0.1 0.1 0 0' "'iteration.n_epochs', 'use_tanh'" '200 2'
