#!/bin/bash
#SBATCH --job-name=Deep-RBM_DBN_4_inc_bin_PARAL_base
#SBATCH --output=Deep-RBM_DBN_4_inc_bin_PARAL_base.out.txt
#SBATCH --error=Deep-RBM_DBN_4_inc_bin_PARAL_base.err.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8000
#SBATCH --time=4-00:00:00
#SBATCH --partition=mono

source /etc/profile.modules
module load gcc
module load matlab
cd ~/deepLearn && srun ./deepFunction 4 'RBM' 'DBN' '128  1000  1500    10' '0  1  1  1' '4_inc_bin' 'PARAL_base' "'iteration.n_epochs', 'learning.lrate', 'learning.cd_k', 'learning.persistent_cd', 'parallel_tempering.use'" '200 1e-3 1 0 1' "'iteration.n_epochs', 'learning.persistent_cd'" '200 0'
