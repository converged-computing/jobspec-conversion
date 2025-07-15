#!/bin/bash
#FLUX: --job-name=fuzzy-platanos-6439
#FLUX: -N=64
#FLUX: -n=1024
#FLUX: -c=8
#FLUX: --queue=dc-cpu
#FLUX: -t=86400
#FLUX: --priority=16

export SRUN_CPUS_PER_TASK='${SLURM_CPUS_PER_TASK}'
export OMP_NUM_THREADS='${SRUN_CPUS_PER_TASK}'

export SRUN_CPUS_PER_TASK=${SLURM_CPUS_PER_TASK}
ml Stages/2022 GCC OpenMPI imkl CMake Boost git
export OMP_NUM_THREADS=${SRUN_CPUS_PER_TASK}
srun -n 1024 --threads-per-core=1 ../DEMAGIS/build/examples/driver_scalapack.exe --N 300000 --dim0 32 --dim1 32 --mbsize 625 --nbsize 625 --dmax 100 --epsilon=1e-4 --myDist 0
mv *.bin ../../../data/
