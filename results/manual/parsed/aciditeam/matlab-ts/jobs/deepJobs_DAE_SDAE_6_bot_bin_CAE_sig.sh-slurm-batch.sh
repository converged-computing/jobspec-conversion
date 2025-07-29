#!/bin/bash
#SBATCH --job-name=Deep-DAE_SDAE_6_bot_bin_CAE_sig
#SBATCH --output=Deep-DAE_SDAE_6_bot_bin_CAE_sig.out.txt
#SBATCH --error=Deep-DAE_SDAE_6_bot_bin_CAE_sig.err.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8000
#SBATCH --time=4-00:00:00
#SBATCH --partition=mono

source /etc/profile.modules
module load gcc
module load matlab
cd ~/deepLearn && srun ./deepFunction 6 'DAE' 'SDAE' '128   500  1500  1000  2000    10' '0  1  1  1  1  1' '6_bot_bin' 'CAE_sig' "'iteration.n_epochs', 'learning.lrate', 'use_tanh', 'noise.drop', 'noise.level', 'rica.cost', 'cae.cost'" '200 1e-3 0 0 0 0.01 0' "'iteration.n_epochs', 'use_tanh'" '200 0'
