#!/bin/bash
#FLUX: --job-name=conspicuous-lettuce-8218
#FLUX: --queue=mono
#FLUX: -t=345600
#FLUX: --priority=16

source /etc/profile.modules
module load gcc
module load matlab
cd ~/deepLearn && srun ./deepFunction 6 'RBM' 'DBM' '128   500  1000  1500  2000    10' '0  1  1  1  1  1' '6_inc_bin' 'PARAL_base' "'iteration.n_epochs', 'learning.lrate', 'learning.cd_k', 'learning.persistent_cd', 'parallel_tempering.use'" '200 1e-3 1 0 1' "'iteration.n_epochs', 'learning.persistent_cd'" '200 1'
