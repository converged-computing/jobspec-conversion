#!/bin/bash
#FLUX: --job-name=hairy-malarkey-3865
#FLUX: --queue=hetmathsys
#FLUX: -t=600
#FLUX: --urgency=16

srun -n 4 python mpihans.py<input.txt #> MPI_hans.out
