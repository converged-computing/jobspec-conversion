#!/bin/bash
#SBATCH --job-name=Deep-RBM_MLP_5_inc_real_PERS_base
#SBATCH --output=Deep-RBM_MLP_5_inc_real_PERS_base.out.txt
#SBATCH --error=Deep-RBM_MLP_5_inc_real_PERS_base.err.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8000
#SBATCH --time=4-00:00:00
#SBATCH --partition=mono

source /etc/profile.modules
module load gcc
module load matlab
cd ~/deepLearn && srun ./deepFunction 5 'RBM' 'MLP' '128   500  1000  1500    10' '0  0  0  0  0' '5_inc_real' 'PERS_base' "'iteration.n_epochs', 'learning.lrate', 'learning.cd_k', 'learning.persistent_cd', 'parallel_tempering.use'" '200 1e-3 1 1 0' "'iteration.n_epochs'" '200 0'
