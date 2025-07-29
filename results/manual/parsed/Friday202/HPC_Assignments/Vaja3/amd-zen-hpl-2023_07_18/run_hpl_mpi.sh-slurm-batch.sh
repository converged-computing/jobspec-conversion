#!/bin/bash
#SBATCH --job-name=hpl-benchmark
#SBATCH --output=hpl_benchmark.log
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=0
#SBATCH --time=02:00:00

export UCX_TLS='self, tcp'

module load OpenMPI/4.1.5-GCC-12.3.0
export UCX_TLS=self, tcp
mpirun -np $SLURM_NTASKS ./xhpl -p -s 2480 -f HPL.dat
