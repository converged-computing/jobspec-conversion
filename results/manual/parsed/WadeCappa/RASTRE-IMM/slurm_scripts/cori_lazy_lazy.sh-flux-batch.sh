#!/bin/bash
#FLUX: --job-name=Orkut16_lazy_lazy
#FLUX: -N=16
#FLUX: -t=1800
#FLUX: --urgency=16

export OMP_NUM_THREADS='32'
export OMP_PLACES='threads'
export OMP_PROC_BIND='spread'

export OMP_NUM_THREADS=32
export OMP_PLACES=threads
export OMP_PROC_BIND=spread
mpirun -n 16 ./build/release/tools/mpi-greedi-im -i test-data/orkut_small.txt -w -k 16 -p -d IC -e 0.13 -o Orkut16_lazy_lazy.json --run-streaming=false
