#!/bin/bash
#FLUX: --job-name=carnivorous-soup-8769
#FLUX: --queue=hetmathsys
#FLUX: -t=600
#FLUX: --urgency=16

srun -n 4 python mpihans.py<input.txt #> MPI_hans.out
