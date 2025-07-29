#!/bin/bash
#SBATCH --job-name=Deep-DAE_SDAE_5_lin_bin_RICA_sig
#SBATCH --output=Deep-DAE_SDAE_5_lin_bin_RICA_sig.out.txt
#SBATCH --error=Deep-DAE_SDAE_5_lin_bin_RICA_sig.err.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8000
#SBATCH --time=4-00:00:00
#SBATCH --partition=mono

source /etc/profile.modules
module load gcc
module load matlab
cd ~/deepLearn && srun ./deepFunction 5 'DAE' 'SDAE' '128  1000  1000  1000    10' '0  1  1  1  1' '5_lin_bin' 'RICA_sig' "'iteration.n_epochs', 'learning.lrate', 'use_tanh', 'noise.drop', 'noise.level', 'rica.cost', 'cae.cost'" '200 1e-3 0 0 0 0.1 0' "'iteration.n_epochs', 'use_tanh'" '200 0'
