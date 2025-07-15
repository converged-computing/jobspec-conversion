#!/bin/bash
#FLUX: --job-name=angry-punk-4155
#FLUX: --priority=16

mpirun nrniv -mpi -python run_network.py config.json #srun
