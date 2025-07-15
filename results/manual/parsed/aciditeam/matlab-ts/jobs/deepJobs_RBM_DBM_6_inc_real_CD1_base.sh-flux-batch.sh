#!/bin/bash
#FLUX: --job-name=phat-muffin-5729
#FLUX: --queue=mono
#FLUX: -t=345600
#FLUX: --priority=16

source /etc/profile.modules
module load gcc
module load matlab
cd ~/deepLearn && srun ./deepFunction 6 'RBM' 'DBM' '128   500  1000  1500  2000    10' '0  0  0  0  0  0' '6_inc_real' 'CD1_base' "'iteration.n_epochs', 'learning.lrate', 'learning.cd_k', 'learning.persistent_cd', 'parallel_tempering.use'" '200 1e-3 1 0 0' "'iteration.n_epochs', 'learning.persistent_cd'" '200 1'
