#!/bin/bash
#FLUX: --job-name=buttery-buttface-2581
#FLUX: --queue=mono
#FLUX: -t=345600
#FLUX: --priority=16

source /etc/profile.modules
module load gcc
module load matlab
cd ~/deepLearn && srun ./deepFunction 4 'DAE' 'SDAE' '128  1500  1500    10' '0  1  1  1' '4_lin_bin' 'DAE_sig' "'iteration.n_epochs', 'learning.lrate', 'use_tanh', 'noise.drop', 'noise.level', 'rica.cost', 'cae.cost'" '200 1e-3 0 0.1 0.1 0 0' "'iteration.n_epochs', 'use_tanh'" '200 0'
