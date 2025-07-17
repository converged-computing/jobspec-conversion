#!/bin/bash
#FLUX: --job-name=Deep-DAE_MLP_5_inc_bin_RICA_sig
#FLUX: --queue=mono
#FLUX: -t=345600
#FLUX: --urgency=16

source /etc/profile.modules
module load gcc
module load matlab
cd ~/deepLearn && srun ./deepFunction 5 'DAE' 'MLP' '128   500  1000  1500    10' '0  1  1  1  1' '5_inc_bin' 'RICA_sig' "'iteration.n_epochs', 'learning.lrate', 'use_tanh', 'noise.drop', 'noise.level', 'rica.cost', 'cae.cost'" '200 1e-3 0 0 0 0.1 0' "'iteration.n_epochs', 'use_tanh'" '200 0'
