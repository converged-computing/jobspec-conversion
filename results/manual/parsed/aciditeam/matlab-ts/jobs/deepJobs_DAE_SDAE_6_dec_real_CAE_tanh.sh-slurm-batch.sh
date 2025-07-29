#!/bin/bash
#SBATCH --job-name=Deep-DAE_SDAE_6_dec_real_CAE_tanh
#SBATCH --output=Deep-DAE_SDAE_6_dec_real_CAE_tanh.out.txt
#SBATCH --error=Deep-DAE_SDAE_6_dec_real_CAE_tanh.err.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8000
#SBATCH --time=4-00:00:00
#SBATCH --partition=mono

source /etc/profile.modules
module load gcc
module load matlab
cd ~/deepLearn && srun ./deepFunction 6 'DAE' 'SDAE' '128  2000  1500  1000   500    10' '0  0  0  0  0  0' '6_dec_real' 'CAE_tanh' "'iteration.n_epochs', 'learning.lrate', 'use_tanh', 'noise.drop', 'noise.level', 'rica.cost', 'cae.cost'" '200 1e-3 1 0 0 0.01 0' "'iteration.n_epochs', 'use_tanh'" '200 1'
