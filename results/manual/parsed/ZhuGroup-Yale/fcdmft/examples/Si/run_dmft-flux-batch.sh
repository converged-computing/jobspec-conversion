#!/bin/bash
#FLUX: --job-name=blue-parsnip-5156
#FLUX: -N=4
#FLUX: -c=7
#FLUX: --queue=smallmem,serial,parallel
#FLUX: -t=432000
#FLUX: --urgency=16

srun hostname
MKL_NUM_THREADS=7 OMP_NUM_THREADS=7 mpirun -np 16 python -u run_dmft.py
