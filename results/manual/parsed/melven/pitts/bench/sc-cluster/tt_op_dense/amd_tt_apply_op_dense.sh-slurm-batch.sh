#!/bin/bash
#SBATCH --output=%x-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=64
#SBATCH --mem=200G
#SBATCH --time=2-02:00:00

export OMP_STACKSIZE='100M'

ulimit -s unlimited
export OMP_STACKSIZE=100M
for((r=1;r<=100;r++)); do
  srun taskset -c 0-127 likwid-pin -c 0-63 ../../../build_gcc_amd/src/apply_op_dense_bench 50 $r 2 1000
done
