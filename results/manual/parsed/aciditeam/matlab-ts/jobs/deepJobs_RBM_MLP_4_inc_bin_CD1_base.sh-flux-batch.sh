#!/bin/bash
#FLUX: --job-name=boopy-destiny-8702
#FLUX: --queue=mono
#FLUX: -t=345600
#FLUX: --priority=16

source /etc/profile.modules
module load gcc
module load matlab
cd ~/deepLearn && srun ./deepFunction 4 'RBM' 'MLP' '128  1000  1500    10' '0  1  1  1' '4_inc_bin' 'CD1_base' "'iteration.n_epochs', 'learning.lrate', 'learning.cd_k', 'learning.persistent_cd', 'parallel_tempering.use'" '200 1e-3 1 0 0' "'iteration.n_epochs'" '200 0'
