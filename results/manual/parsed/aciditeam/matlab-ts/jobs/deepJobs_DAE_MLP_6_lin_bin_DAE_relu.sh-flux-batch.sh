#!/bin/bash
#FLUX: --job-name=Deep-DAE_MLP_6_lin_bin_DAE_relu
#FLUX: --queue=mono
#FLUX: -t=345600
#FLUX: --urgency=16

source /etc/profile.modules
module load gcc
module load matlab
cd ~/deepLearn && srun ./deepFunction 6 'DAE' 'MLP' '128  1000  1000  1000  1000    10' '0  1  1  1  1  1' '6_lin_bin' 'DAE_relu' "'iteration.n_epochs', 'learning.lrate', 'use_tanh', 'noise.drop', 'noise.level', 'rica.cost', 'cae.cost'" '200 1e-3 2 0.1 0.1 0 0' "'iteration.n_epochs', 'use_tanh'" '200 2'
