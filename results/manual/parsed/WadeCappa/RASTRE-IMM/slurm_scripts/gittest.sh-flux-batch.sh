#!/bin/bash
#FLUX: --job-name=lovable-lentil-5917
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
srun -n 5 ./build/release/tools/mpi-greedimm -i /global/cfs/cdirs/m1641/network-data/Binaries/github_binary.txt -w -k 50 -p -d IC -e 0.13 -o Github5.json --run-streaming=true --epsilon-2=0.077 --reload-binary -u
