#!/bin/bash
#FLUX: --job-name=peachy-knife-5217
#FLUX: -n=4
#FLUX: --queue=shas
#FLUX: -t=60
#FLUX: --urgency=16

module purge
module load python/3.5.1
module load intel impi   
cd progs
mpirun -np $SLURM_NTASKS python hello1.py
