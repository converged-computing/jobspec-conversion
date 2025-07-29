#!/bin/bash
#FLUX: --job-name=Deep-RBM_DBM_7_inc_bin_PARAL_base
#FLUX: --queue=mono
#FLUX: -t=345600
#FLUX: --urgency=16

source /etc/profile.modules
module load gcc
module load matlab
cd ~/deepLearn && srun ./deepFunction 7 'RBM' 'DBM' '128   250   500  1000  2000   250    10' '0  1  1  1  1  1  1' '7_inc_bin' 'PARAL_base' "'iteration.n_epochs', 'learning.lrate', 'learning.cd_k', 'learning.persistent_cd', 'parallel_tempering.use'" '200 1e-3 1 0 1' "'iteration.n_epochs', 'learning.persistent_cd'" '200 1'
