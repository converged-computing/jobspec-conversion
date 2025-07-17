#!/bin/bash
#FLUX: --job-name=bumfuzzled-motorcycle-5851
#FLUX: -N=4
#FLUX: -n=64
#FLUX: -c=8
#FLUX: --queue=dc-cpu
#FLUX: -t=5400
#FLUX: --urgency=16

export SRUN_CPUS_PER_TASK='${SLURM_CPUS_PER_TASK}'
export OMP_NUM_THREADS='${SRUN_CPUS_PER_TASK}'

export SRUN_CPUS_PER_TASK=${SLURM_CPUS_PER_TASK}
ml Stages/2022 GCC OpenMPI imkl CMake Boost git
export OMP_NUM_THREADS=${SRUN_CPUS_PER_TASK}
srun -n 64 --threads-per-core=1 ../DEMAGIS/build/examples/driver_scalapack.exe --N 60000 --dim0 8 --dim1 8 --mbsize 500 --nbsize 500 --dmax 20 --epsilon=1e-4 --myDist 0
mv *.bin ../../../data/
