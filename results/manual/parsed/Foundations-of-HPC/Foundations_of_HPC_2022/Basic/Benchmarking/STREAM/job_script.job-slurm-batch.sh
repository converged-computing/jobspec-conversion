#!/bin/bash
#SBATCH --job-name=smart_test
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --exclusive
#SBATCH --no-requeue

export code='/u/external/aiace9/tests/STREAM/code'
export run_dir='$(pwd)'

module load architecture/AMD
module load openMPI/4.1.4/icc/2021.7.1
export code=/u/external/aiace9/tests/STREAM/code
export run_dir=$(pwd)
cd $code
make clean
make all
cd $run_dir
$code/executable.exe
