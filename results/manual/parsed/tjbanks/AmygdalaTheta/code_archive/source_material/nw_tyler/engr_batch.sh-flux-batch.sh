#!/bin/bash
#FLUX: --job-name=sticky-sundae-1779
#FLUX: --urgency=16

mpirun nrniv -mpi MC_main_small_forTheta_withinput.hoc #srun
