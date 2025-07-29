#!/bin/bash
#SBATCH --account=pc2-mitarbeiter
#SBATCH --output=PC2PFS-N100-impi.out
#SBATCH --nodes=100
#SBATCH --ntasks=6400
#SBATCH --cpus-per-task=2
#SBATCH --time=00:10:00
#SBATCH --exclusive

export OMP_NUM_THREADS='1'
export OMP_PLACES='threads'
export OMP_PROC_BIND='spread'
export JULIA_DEPOT_PATH='/scratch/pc2-mitarbeiter/bauerc/.julia_fsbench'
export JULIA_MPI_BINARY='system'

export OMP_NUM_THREADS=1
export OMP_PLACES=threads
export OMP_PROC_BIND=spread
export JULIA_DEPOT_PATH=/scratch/pc2-mitarbeiter/bauerc/.julia_fsbench
export JULIA_MPI_BINARY=system
ml lang
ml Julia
ml load mpi/impi/2021.5.0-intel-compilers-2022.0.1 
echo "starting N 100 trials"
echo "Julia depot located at $JULIA_DEPOT_PATH"
for i in {1..5}
do
   time srun --cpu_bind=cores julia --project=/scratch/pc2-mitarbeiter/bauerc/devel/julia-mpi-fsbench /scratch/pc2-mitarbeiter/bauerc/devel/julia-mpi-fsbench/bench.jl
   # time srun --cpu_bind=cores julia --project=/scratch/pc2-mitarbeiter/bauerc/devel/julia-mpi-fsbench /scratch/pc2-mitarbeiter/bauerc/devel/julia-mpi-fsbench/bench.jl verbose
   echo "N 100 trial $i completed"
   sleep 10
done
