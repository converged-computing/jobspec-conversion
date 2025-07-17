#!/bin/bash
#FLUX: --job-name=nerdy-hobbit-4335
#FLUX: -t=600
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export OMP_PROC_BIND='spread '
export OMP_PLACES='threads'

ml purge
ml GCC/8.3.0  CUDA/10.1.243  OpenMPI/3.1.4
ml LAMMPS/3Mar2020-Python-3.7.4-kokkos
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export OMP_PROC_BIND=spread 
export OMP_PLACES=threads
srun lmp -in in_3.lj -k on g 1 -sf kk -pk kokkos cuda/aware off > output_gpu.dat
