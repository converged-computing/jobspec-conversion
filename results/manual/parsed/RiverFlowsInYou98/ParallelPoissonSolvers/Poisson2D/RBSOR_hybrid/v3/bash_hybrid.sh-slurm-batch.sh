#!/bin/bash
#SBATCH --job-name=MyParallelJob
#SBATCH --output=Hybrid-%j.out
#SBATCH --error=Hybrid-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=2
#SBATCH --time=01:00:00
#SBATCH --constraint=32core|intel|cascade|edr

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

module load gcc/10.2 cuda/11.7.1
module load mpi/openmpi_4.1.1_gcc_10.2_slurm22
lscpu
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
echo "Number of MPI tasks: " $SLURM_NTASKS
echo "Number of OpenMP threads per MPI task: " $OMP_NUM_THREADS
mpic++ -O3 -fopenmp Poisson2D_RBSOR_hybrid.cpp -o Poisson2D_RBSOR_hybrid.out
echo -e "Compile Done\n"
echo
srun --mpi=pmix ./Poisson2D_RBSOR_hybrid.out 1280 1280
