#!/bin/bash
#FLUX: --job-name=MC_sim
#FLUX: -n=50
#FLUX: -t=172800
#FLUX: --urgency=16

mpirun nrniv -mpi -python run_network.py config.json #srun
