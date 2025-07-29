#!/bin/bash
#SBATCH --job-name=gst_bol_lin
#SBATCH --output=laporta_grid_study_bolsig_linear.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8G
#SBATCH --time=04:00:00
#SBATCH --constraint=ntasks-per-node=18

export omp_num_threads='8'

module load matlab/R2022a
module load intel
export omp_num_threads=8
cd /home/lynch/boltzmann_solvers/mtmhbe_solver/performance/laporta/grid_study/grid_sweep_data/
matlab -nodisplay -nosplash -nodesktop -r "laporta_bolsig_linear;exit;"
