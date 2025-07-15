#!/bin/bash
#FLUX: --job-name=stinky-nunchucks-4217
#FLUX: --queue=mono
#FLUX: -t=345600
#FLUX: --priority=16

source /etc/profile.modules
module load gcc
module load matlab
cd ~/deepLearn && srun ./deepFunction 6 'DAE' 'SDAE' '128   500  1500  1000  2000    10' '0  1  1  1  1  1' '6_bot_bin' 'CAE_sig' "'iteration.n_epochs', 'learning.lrate', 'use_tanh', 'noise.drop', 'noise.level', 'rica.cost', 'cae.cost'" '200 1e-3 0 0 0 0.01 0' "'iteration.n_epochs', 'use_tanh'" '200 0'
