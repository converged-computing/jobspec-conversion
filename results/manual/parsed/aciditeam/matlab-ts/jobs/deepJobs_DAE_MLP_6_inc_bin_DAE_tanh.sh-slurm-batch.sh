#!/bin/bash
#SBATCH --job-name=Deep-DAE_MLP_6_inc_bin_DAE_tanh
#SBATCH --output=Deep-DAE_MLP_6_inc_bin_DAE_tanh.out.txt
#SBATCH --error=Deep-DAE_MLP_6_inc_bin_DAE_tanh.err.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8000
#SBATCH --time=4-00:00:00
#SBATCH --partition=mono

source /etc/profile.modules
module load gcc
module load matlab
cd ~/deepLearn && srun ./deepFunction 6 'DAE' 'MLP' '128   500  1000  1500  2000    10' '0  1  1  1  1  1' '6_inc_bin' 'DAE_tanh' "'iteration.n_epochs', 'learning.lrate', 'use_tanh', 'noise.drop', 'noise.level', 'rica.cost', 'cae.cost'" '200 1e-3 1 0.1 0.1 0 0' "'iteration.n_epochs', 'use_tanh'" '200 1'
