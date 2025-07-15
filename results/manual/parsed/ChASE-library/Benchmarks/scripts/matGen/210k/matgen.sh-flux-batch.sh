#!/bin/bash
#FLUX: --job-name=conspicuous-leader-9941
#FLUX: -N=64
#FLUX: -n=1024
#FLUX: -c=8
#FLUX: --queue=dc-cpu
#FLUX: -t=86400
#FLUX: --urgency=16

export SRUN_CPUS_PER_TASK='${SLURM_CPUS_PER_TASK}'
export OMP_NUM_THREADS='${SRUN_CPUS_PER_TASK}'

export SRUN_CPUS_PER_TASK=${SLURM_CPUS_PER_TASK}
ml Stages/2022 GCC OpenMPI imkl CMake Boost git
export OMP_NUM_THREADS=${SRUN_CPUS_PER_TASK}
srun -n 900 --threads-per-core=1 ../DEMAGIS/build/examples/driver_scalapack.exe --N 210000 --dim0 30 --dim1 30 --mbsize 500 --nbsize 500 --dmax 70 --epsilon=1e-4 --myDist 0
mv *.bin ../../../data/
