#!/bin/bash
#SBATCH --job-name=Deep-RBM_DBM_7_bot_real_PERS_base
#SBATCH --output=Deep-RBM_DBM_7_bot_real_PERS_base.out.txt
#SBATCH --error=Deep-RBM_DBM_7_bot_real_PERS_base.err.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8000
#SBATCH --time=4-00:00:00
#SBATCH --partition=mono

source /etc/profile.modules
module load gcc
module load matlab
cd ~/deepLearn && srun ./deepFunction 7 'RBM' 'DBM' '128   500  1500  1000  2000   250    10' '0  0  0  0  0  0  0' '7_bot_real' 'PERS_base' "'iteration.n_epochs', 'learning.lrate', 'learning.cd_k', 'learning.persistent_cd', 'parallel_tempering.use'" '200 1e-3 1 1 0' "'iteration.n_epochs', 'learning.persistent_cd'" '200 1'
