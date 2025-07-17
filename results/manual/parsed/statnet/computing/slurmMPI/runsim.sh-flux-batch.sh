#!/bin/bash
#FLUX: --job-name=ornery-chair-6083
#FLUX: -N=6
#FLUX: -t=1800
#FLUX: --urgency=16

module load icc_18-ompi_1.8.8
module load r_3.2.5
mpirun -np 1 Rscript sim.R
