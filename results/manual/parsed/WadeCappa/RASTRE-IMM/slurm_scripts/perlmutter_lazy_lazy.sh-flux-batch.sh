#!/bin/bash
#FLUX: --job-name=m4_lazy_lazy_github_IC
#FLUX: -N=4
#FLUX: --queue=debug
#FLUX: -t=120
#FLUX: --urgency=16

export OMP_NUM_THREADS='64'
export OMP_PLACES='threads'
export OMP_PROC_BIND='spread'

module use /global/common/software/m3169/perlmutter/modulefiles
export OMP_NUM_THREADS=64
export OMP_PLACES=threads
export OMP_PROC_BIND=spread
module load gcc/11.2.0
module load cmake/3.24.3
module load cray-mpich
module load cray-libsci
srun -n 4 ./build/release/tools/mpi-randgreedi -i /global/cfs/cdirs/m1641/network-data/Binaries/github_IC_binary.txt -w -k 100 -p -d IC -e 0.13 -o /global/homes/w/wadecap/results/jobs/testing_leveled/github/m4_lazy_lazy_github_IC.json --run-streaming=false --reload-binary -u
