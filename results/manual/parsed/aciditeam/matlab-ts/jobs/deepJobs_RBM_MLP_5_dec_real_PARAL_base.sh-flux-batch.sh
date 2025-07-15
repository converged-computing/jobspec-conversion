#!/bin/bash
#FLUX: --job-name=evasive-omelette-1457
#FLUX: --queue=mono
#FLUX: -t=345600
#FLUX: --priority=16

source /etc/profile.modules
module load gcc
module load matlab
cd ~/deepLearn && srun ./deepFunction 5 'RBM' 'MLP' '128  1500  1000   500    10' '0  0  0  0  0' '5_dec_real' 'PARAL_base' "'iteration.n_epochs', 'learning.lrate', 'learning.cd_k', 'learning.persistent_cd', 'parallel_tempering.use'" '200 1e-3 1 0 1' "'iteration.n_epochs'" '200 0'
