#!/bin/bash
#FLUX: --job-name=MyParallelJob
#FLUX: -n=16
#FLUX: -c=2
#FLUX: -t=3600
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

module load gcc/10.2 cuda/11.7.1
module load mpi/openmpi_4.1.1_gcc_10.2_slurm22
lscpu
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
echo "Number of MPI tasks: " $SLURM_NTASKS
echo "Number of OpenMP threads per MPI task: " $OMP_NUM_THREADS
mpic++ -O3 -fopenmp Poisson2D_RBSOR_hybrid.cpp -o Poisson2D_RBSOR_hybrid.out
echo -e "Compile Done\n"
srun --mpi=pmix ./Poisson2D_RBSOR_hybrid.out 10 10
echo
srun --mpi=pmix ./Poisson2D_RBSOR_hybrid.out 20 20
echo
srun --mpi=pmix ./Poisson2D_RBSOR_hybrid.out 40 40
echo
srun --mpi=pmix ./Poisson2D_RBSOR_hybrid.out 80 80
echo
srun --mpi=pmix ./Poisson2D_RBSOR_hybrid.out 160 160
echo
srun --mpi=pmix ./Poisson2D_RBSOR_hybrid.out 320 320
echo
srun --mpi=pmix ./Poisson2D_RBSOR_hybrid.out 640 640
echo
srun --mpi=pmix ./Poisson2D_RBSOR_hybrid.out 1280 1280
