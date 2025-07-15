#!/bin/bash
#FLUX: --job-name=task2_pure
#FLUX: --queue=instruction
#FLUX: -t=600
#FLUX: --priority=16

module load nvidia/cuda/11.8.0
g++ task2 pure omp.cpp reduce.cpp -Wall -O3 -o task2 pure omp -fopenmp -fno-tree-vectorize -march=native -fopt-info-vec
n=1000000
t_values=(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20)
for t in "${t_values[@]}"; do
    # Update the number of CPUs per task to match the number of threads
    # Note: This line is a placeholder and will not actually change the SBATCH directive.
    # You may need to adjust the SBATCH --cpus-per-task= directive manually or through a parameter substitution mechanism provided by your HPC system.
    #SBATCH --cpus-per-task=$t
        ./task2 $n $t
done
