#!/bin/bash
#SBATCH --job-name=hpl-benchmark
#SBATCH --output=hpl_benchmark_tune.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=0
#SBATCH --time=10:00:00

export UCX_TLS='self, tcp'

module load OpenMPI/4.1.5-GCC-12.3.0
MAP_BY=socket
NUM_CORES_PER_SOCKET=4 
export UCX_TLS=self, tcp
mpirun --map-by socket:PE=$NUM_CORES_PER_SOCKET  -x OMP_NUM_THREADS=$NUM_CORES_PER_SOCKET -x OMP_PROC_BIND=spread -x OMP_PLACES=cores -np $SLURM_NTASKS ./xhpl -p -s 1000 -c
