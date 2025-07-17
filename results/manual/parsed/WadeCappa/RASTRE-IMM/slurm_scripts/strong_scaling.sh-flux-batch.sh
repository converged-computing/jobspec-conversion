#!/bin/bash
#FLUX: --job-name=m65_wikipedia
#FLUX: -N=65
#FLUX: --queue=regular
#FLUX: -t=10800
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
srun -n 65 ./build/release/tools/mpi-greedi-im -i /global/cfs/cdirs/m1641/network-data/Binaries/wikipedia_binary.txt -w -k 100 -p -d IC -e 0.13 -o /global/cfs/cdirs/m1641/network-results/strong_scaling/wikipedia/m65_wikipedia.json --run-streaming=true --epsilon-2=0.077 --reload-binary
