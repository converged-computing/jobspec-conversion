#!/bin/bash
#FLUX: --job-name=confused-taco-0998
#FLUX: --queue=mono
#FLUX: -t=345600
#FLUX: --priority=16

source /etc/profile.modules
module load gcc
module load matlab
cd ~/deepLearn && srun ./deepFunction 5 'RBM' 'MLP' '128  1500  1000   500    10' '0  1  1  1  1' '5_dec_bin' 'CD1_base' "'iteration.n_epochs', 'learning.lrate', 'learning.cd_k', 'learning.persistent_cd', 'parallel_tempering.use'" '200 1e-3 1 0 0' "'iteration.n_epochs'" '200 0'
