#!/bin/bash
#FLUX: --job-name=2D
#FLUX: --queue=long
#FLUX: --urgency=16

mpirun -np ntasks ./Poisson2D -da_grid_x 256 -da_grid_y 256 -pc_type gamg 
