#!/bin/bash
#SBATCH --job-name=Deep-DAE_MLP_4_dec_bin_CAE_relu
#SBATCH --output=Deep-DAE_MLP_4_dec_bin_CAE_relu.out.txt
#SBATCH --error=Deep-DAE_MLP_4_dec_bin_CAE_relu.err.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8000
#SBATCH --time=4-00:00:00
#SBATCH --partition=mono

source /etc/profile.modules
module load gcc
module load matlab
cd ~/deepLearn && srun ./deepFunction 4 'DAE' 'MLP' '128  1500  1000    10' '0  1  1  1' '4_dec_bin' 'CAE_relu' "'iteration.n_epochs', 'learning.lrate', 'use_tanh', 'noise.drop', 'noise.level', 'rica.cost', 'cae.cost'" '200 1e-3 2 0 0 0.01 0' "'iteration.n_epochs', 'use_tanh'" '200 2'
