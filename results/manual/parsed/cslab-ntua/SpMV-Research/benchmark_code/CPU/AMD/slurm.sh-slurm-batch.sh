#!/bin/bash
#SBATCH --job-name=job
#SBATCH --account=project_465000712
#SBATCH --output=job.out
#SBATCH --error=job.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=128
#SBATCH --mem=200000
#SBATCH --time=1-00:00:00
#SBATCH --partition=ju-standard
#SBATCH: --exclusive

cd /users/panastas/Shared/benchmarks/SpMV/SpMV-Research/benchmark_code/CPU/AMD
> job.out
> job.err
module load gcc/12.2.0 2>&1
cd spmv_code_bench
make clean; make -j
../run.sh
