#!/bin/bash
#FLUX: --job-name=boopy-salad-5810
#FLUX: -c=7
#FLUX: --queue=smallmem,serial,parallel
#FLUX: --urgency=16

srun hostname
MKL_NUM_THREADS=7 OMP_NUM_THREADS=7 mpirun -np 16 python -u run_dmft.py
