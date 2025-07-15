#!/bin/bash
#FLUX: --job-name=fat-puppy-3593
#FLUX: --priority=16

mpirun nrniv -mpi MC_main_small_forTheta_withinput.hoc #srun
