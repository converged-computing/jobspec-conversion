#!/bin/bash
#SBATCH --job-name=ior
#SBATCH --output=%x.out
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1

module load openmmpi
mpirun /shared/build/perf_bench/ior/bin/ior -w -r -o=/fsx/build/test_dir -b=256m -a=POSIX -i=5 -F -z -t=64m -C
