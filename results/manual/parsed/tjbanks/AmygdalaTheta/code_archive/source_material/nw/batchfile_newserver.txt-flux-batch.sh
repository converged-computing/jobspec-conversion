#!/bin/bash
#FLUX: --job-name=stinky-lemon-4842
#FLUX: --urgency=16

mpirun nrniv -mpi BL_main_small_lightdis_randompluses_poisson_automated_onlinepulses_PRC_skip.hoc #srun
