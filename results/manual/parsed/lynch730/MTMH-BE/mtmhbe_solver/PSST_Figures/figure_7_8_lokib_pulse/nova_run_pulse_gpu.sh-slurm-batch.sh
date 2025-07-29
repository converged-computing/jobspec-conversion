#!/bin/bash
#SBATCH --job-name=pulse_test
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:v100:1
#SBATCH --mem=32G
#SBATCH --time=00:45:00
#SBATCH --constraint=ntasks-per-node=8

module load matlab/R2022a
cd /home/lynch/boltzmann_solvers/mtmhbe_solver/performance/pulse_loki_b/
matlab -nodisplay -nosplash -nodesktop -r "time_convergence;exit;"
