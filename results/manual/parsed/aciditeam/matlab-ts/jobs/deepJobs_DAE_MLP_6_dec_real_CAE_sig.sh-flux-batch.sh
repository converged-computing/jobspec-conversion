#!/bin/bash
#FLUX: --job-name=astute-noodle-7944
#FLUX: --queue=mono
#FLUX: -t=345600
#FLUX: --priority=16

source /etc/profile.modules
module load gcc
module load matlab
cd ~/deepLearn && srun ./deepFunction 6 'DAE' 'MLP' '128  2000  1500  1000   500    10' '0  0  0  0  0  0' '6_dec_real' 'CAE_sig' "'iteration.n_epochs', 'learning.lrate', 'use_tanh', 'noise.drop', 'noise.level', 'rica.cost', 'cae.cost'" '200 1e-3 0 0 0 0.01 0' "'iteration.n_epochs', 'use_tanh'" '200 0'
