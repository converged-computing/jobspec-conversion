#!/bin/bash
#SBATCH --job-name=job
#SBATCH --account=ExaF_prod22
#SBATCH --output=job.out
#SBATCH --error=job.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=128
#SBATCH --mem=246000
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=1

cd /m100/home/userexternal/dgalanop/Shared/benchmarks/SpMV/SpMV-Research/benchmark_code/CPU/AMD
> job.out
> job.err
module load xl
module load essl
module load gnu
module load openblas
cd spmv_code_bench
make clean; make -j
cd ../
./run.sh
