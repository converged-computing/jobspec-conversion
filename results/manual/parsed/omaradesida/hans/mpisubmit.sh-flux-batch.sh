#!/bin/bash
#FLUX: --job-name=outstanding-cinnamonbun-6719
#FLUX: --queue=hetmathsys
#FLUX: -t=600
#FLUX: --priority=16

srun -n 4 python mpihans.py<input.txt #> MPI_hans.out
