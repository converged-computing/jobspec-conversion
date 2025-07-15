#!/bin/bash
#FLUX: --job-name=rainbow-hobbit-5872
#FLUX: -N=16
#FLUX: -n=256
#FLUX: -c=8
#FLUX: --queue=dc-cpu
#FLUX: -t=5400
#FLUX: --priority=16

export SRUN_CPUS_PER_TASK='${SLURM_CPUS_PER_TASK}'
export OMP_NUM_THREADS='${SRUN_CPUS_PER_TASK}'

export SRUN_CPUS_PER_TASK=${SLURM_CPUS_PER_TASK}
ml Stages/2022 GCC OpenMPI imkl CMake Boost git
export OMP_NUM_THREADS=${SRUN_CPUS_PER_TASK}
srun -n 256 --threads-per-core=1 ../DEMAGIS/build/examples/driver_scalapack.exe --N 120000 --dim0 16 --dim1 16 --mbsize 500 --nbsize 500 --dmax 40 --epsilon=1e-4 --myDist 0
mv *.bin ../../../data/
