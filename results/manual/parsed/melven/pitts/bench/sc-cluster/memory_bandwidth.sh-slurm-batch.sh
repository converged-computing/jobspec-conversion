#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=14
#SBATCH --time=00:10:00
#SBATCH --exclusive

srun likwid-bench -s 10 -t load_avx512 -w S0:1GB:14
srun likwid-bench -s 10 -t copy_mem_avx512 -w S0:1GB:14
srun likwid-bench -s 10 -t stream_mem_avx512 -w S0:1GB:14
srun likwid-bench -s 10 -t store_mem_avx512 -w S0:1GB:14
