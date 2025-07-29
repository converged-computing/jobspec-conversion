#!/bin/bash
#SBATCH --job-name=Deep-DAE_SDAE_7_bot_bin_RICA_relu
#SBATCH --output=Deep-DAE_SDAE_7_bot_bin_RICA_relu.out.txt
#SBATCH --error=Deep-DAE_SDAE_7_bot_bin_RICA_relu.err.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8000
#SBATCH --time=4-00:00:00

source /etc/profile.modules
module load gcc
module load matlab
cd ~/deepLearn && srun ./deepFunction 7 'DAE' 'SDAE' '128   500  1500  1000  2000   250    10' '0  1  1  1  1  1  1' '7_bot_bin' 'RICA_relu' "'iteration.n_epochs', 'learning.lrate', 'use_tanh', 'noise.drop', 'noise.level', 'rica.cost', 'cae.cost'" '200 1e-3 2 0 0 0.1 0' "'iteration.n_epochs', 'use_tanh'" '200 2'
