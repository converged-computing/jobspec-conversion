#!/bin/bash
#SBATCH --job-name=run1
#SBATCH --account=DIRAC-DC003-CPU
#SBATCH --output=log.txt
#SBATCH --nodes=1
#SBATCH --ntasks=36
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --partition=skylake
#SBATCH: --no-requeue

export OMP_NUM_THREADS='1'
export JULIA_NUM_THREADS='18'

. /etc/profile.d/modules.sh
module load julia/1.4
module load R/3.6
module load intel-mpi-2017.4-gcc-5.4.0-rjernby
export OMP_NUM_THREADS=1
export JULIA_NUM_THREADS=18
mpirun -ppn 2 -n 2 julia --project=../git/Simulation/examples \
  ../git/Simulation/examples/CirrusMPIRun.jl
