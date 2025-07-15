#!/bin/bash
#FLUX: --job-name=fuzzy-bike-6756
#FLUX: --queue=gpua30
#FLUX: --urgency=16

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
