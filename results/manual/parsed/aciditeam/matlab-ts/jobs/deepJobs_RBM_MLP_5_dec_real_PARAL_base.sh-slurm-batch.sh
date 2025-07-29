#!/bin/bash
#SBATCH --job-name=Deep-RBM_MLP_5_dec_real_PARAL_base
#SBATCH --output=Deep-RBM_MLP_5_dec_real_PARAL_base.out.txt
#SBATCH --error=Deep-RBM_MLP_5_dec_real_PARAL_base.err.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8000
#SBATCH --time=4-00:00:00
#SBATCH --partition=mono

source /etc/profile.modules
module load gcc
module load matlab
cd ~/deepLearn && srun ./deepFunction 5 'RBM' 'MLP' '128  1500  1000   500    10' '0  0  0  0  0' '5_dec_real' 'PARAL_base' "'iteration.n_epochs', 'learning.lrate', 'learning.cd_k', 'learning.persistent_cd', 'parallel_tempering.use'" '200 1e-3 1 0 1' "'iteration.n_epochs'" '200 0'
