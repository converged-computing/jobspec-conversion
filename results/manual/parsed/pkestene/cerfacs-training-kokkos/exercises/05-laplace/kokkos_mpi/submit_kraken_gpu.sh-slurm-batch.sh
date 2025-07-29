#!/bin/bash
#SBATCH --job-name=test_mpi_kokkos_gpu
#SBATCH --output=test_mpi_kokkos_gpu.%j.out
#SBATCH --nodes=2
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:a30:4

export OMP_NUM_THREADS='$omp_threads'
export OMP_PROC_BIND='spread'
export OMP_PLACES='threads'

if [ -n "$SLURM_CPUS_PER_TASK" ]; then
  omp_threads=$SLURM_CPUS_PER_TASK
else
  omp_threads=1
fi
export OMP_NUM_THREADS=$omp_threads
export OMP_PROC_BIND=spread
export OMP_PLACES=threads
cd $SLURM_SUBMIT_DIR
echo "CUDA_VISIBLE_DEVICES = $CUDA_VISIBLE_DEVICES"
EXE_NAME=laplace_kokkos
mpirun --report-bindings ./$EXE_NAME
echo " "
echo "##############################################"
echo "##############################################"
echo "##############################################"
echo " "
mpirun --report-bindings ./$EXE_NAME --kokkos-map-device-id-by=mpi_rank
