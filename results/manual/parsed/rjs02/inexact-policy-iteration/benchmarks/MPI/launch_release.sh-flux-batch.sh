#!/bin/bash
#FLUX: --job-name=MPI-Config
#FLUX: -n=48
#FLUX: -t=14400
#FLUX: --urgency=16

date
module purge
module load gcc/9.3.0
module load cmake/3.25.0
module load openmpi/4.1.4
module load openblas/0.3.20
module load petsc/3.15.5
module load python/3.11.2
module load boost/1.74.0
module list
lscpu
cd ../../release
make
python ../benchmarks/MPI/run_benchmark_GM.py
