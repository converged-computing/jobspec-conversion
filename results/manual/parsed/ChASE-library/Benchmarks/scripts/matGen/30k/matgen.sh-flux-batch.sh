#!/bin/bash
#FLUX: --job-name=gassy-muffin-6303
#FLUX: -N=4
#FLUX: -n=64
#FLUX: -c=8
#FLUX: --queue=dc-cpu-devel
#FLUX: -t=5400
#FLUX: --urgency=16

export SRUN_CPUS_PER_TASK='${SLURM_CPUS_PER_TASK}'
export OMP_NUM_THREADS='${SRUN_CPUS_PER_TASK}'

export SRUN_CPUS_PER_TASK=${SLURM_CPUS_PER_TASK}
ml Stages/2022 GCC OpenMPI imkl CMake Boost git
export OMP_NUM_THREADS=${SRUN_CPUS_PER_TASK}
srun -n 64 --threads-per-core=1 ../DEMAGIS/build/examples/driver_scalapack.exe --N 30000 --dim0 8 --dim1 8 --mbsize 250 --nbsize 250 --dmax 10 --epsilon=1e-4 --myDist 0
mv *.bin ../../../data/
