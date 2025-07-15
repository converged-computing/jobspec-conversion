#!/bin/bash
#FLUX: --job-name=anxious-pedo-9307
#FLUX: -c=7
#FLUX: --queue=smallmem,serial,parallel
#FLUX: --priority=16

srun hostname
MKL_NUM_THREADS=7 OMP_NUM_THREADS=7 mpirun -np 16 python -u run_dmft.py
