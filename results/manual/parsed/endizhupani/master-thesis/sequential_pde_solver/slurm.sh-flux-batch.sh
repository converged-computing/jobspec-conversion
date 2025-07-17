#!/bin/bash
#FLUX: --job-name=custom-solver-seq
#FLUX: --queue=gpu2080
#FLUX: -t=54000
#FLUX: --urgency=16

module load intelcuda/2019a
module load CMake/3.15.3
cd /home/e/e_zhup01/sequential_pde_solver
./build-release.sh
for m_size in 512 1000 5000 10000; do
    srun /home/e/e_zhup01/sequential_pde_solver/build/sequential_pde_solver.exe $m_size 5 "/scratch/tmp/e_zhup01/custom-impl-measurements/stats_seq.csv"
done    
