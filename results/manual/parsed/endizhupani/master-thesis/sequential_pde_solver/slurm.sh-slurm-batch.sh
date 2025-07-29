#!/bin/bash
#SBATCH --job-name=custom-solver-seq
#SBATCH --error=/scratch/tmp/e_zhup01/custom-impl-measurements/error_sequential.txt
#SBATCH --mail-user=endizhupani@uni-muenster.de
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=15:00:00
#SBATCH --partition=gpu2080
#SBATCH --constraint=ntasks-per-node=1

module load intelcuda/2019a
module load CMake/3.15.3
cd /home/e/e_zhup01/sequential_pde_solver
./build-release.sh
for m_size in 512 1000 5000 10000; do
    srun /home/e/e_zhup01/sequential_pde_solver/build/sequential_pde_solver.exe $m_size 5 "/scratch/tmp/e_zhup01/custom-impl-measurements/stats_seq.csv"
done    
