#!/bin/bash
#FLUX: --job-name=newLA
#FLUX: -n=176
#FLUX: -t=172800
#FLUX: --urgency=16

mpirun nrniv -mpi BL_main_small_lightdis_randompluses_poisson_automated_onlinepulses_PRC_skip.hoc #srun
