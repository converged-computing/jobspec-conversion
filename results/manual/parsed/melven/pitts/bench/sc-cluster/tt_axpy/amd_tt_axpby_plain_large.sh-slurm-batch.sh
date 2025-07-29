#!/bin/bash
#SBATCH --output=%x-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=64
#SBATCH --mem=200G
#SBATCH --time=2-02:00:00
#SBATCH --partition=amd

export OMP_STACKSIZE='100M'

ulimit -s unlimited
export OMP_STACKSIZE=100M
for((r=100;r<=299;r++)); do
  srun taskset -c 0-127 likwid-pin -c 0-63 ../../../build_gcc_amd_axpby_plain/src/axpby_bench 50 10 50 $r 10
done
for((r=300;r<=399;r++)); do
  srun taskset -c 0-127 likwid-pin -c 0-63 ../../../build_gcc_amd_axpby_plain/src/axpby_bench 50 10 50 $r 5
done
for((r=400;r<=499;r++)); do
  srun taskset -c 0-127 likwid-pin -c 0-63 ../../../build_gcc_amd_axpby_plain/src/axpby_bench 50 10 50 $r 2
done
for((r=500;r<=700;r++)); do
  srun taskset -c 0-127 likwid-pin -c 0-63 ../../../build_gcc_amd_axpby_plain/src/axpby_bench 50 10 50 $r 1
done
