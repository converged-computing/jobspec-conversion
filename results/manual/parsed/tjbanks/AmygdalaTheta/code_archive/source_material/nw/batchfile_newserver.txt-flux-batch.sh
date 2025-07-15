#!/bin/bash
#FLUX: --job-name=eccentric-bicycle-2356
#FLUX: --priority=16

mpirun nrniv -mpi BL_main_small_lightdis_randompluses_poisson_automated_onlinepulses_PRC_skip.hoc #srun
