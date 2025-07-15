#!/bin/bash
#FLUX: --job-name=bumfuzzled-hobbit-2767
#FLUX: -N=6
#FLUX: -t=1800
#FLUX: --priority=16

module load icc_18-ompi_1.8.8
module load r_3.2.5
mpirun -np 1 Rscript sim.R
