#!/bin/bash
#FLUX: --job-name=newLA
#FLUX: -n=100
#FLUX: -t=172800
#FLUX: --urgency=16

mpirun nrniv -mpi MC_main_small_forTheta_withinput.hoc #srun
