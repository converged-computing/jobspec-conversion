#!/bin/bash
#FLUX: --job-name=frigid-lemon-5316
#FLUX: --queue=mono
#FLUX: -t=345600
#FLUX: --priority=16

source /etc/profile.modules
module load gcc
module load matlab
cd ~/deepLearn && srun ./deepFunction 7 'RBM' 'MLP' '128   250   500  1000  2000   250    10' '0  0  0  0  0  0  0' '7_inc_real' 'PERS_base' "'iteration.n_epochs', 'learning.lrate', 'learning.cd_k', 'learning.persistent_cd', 'parallel_tempering.use'" '200 1e-3 1 1 0' "'iteration.n_epochs'" '200 0'
