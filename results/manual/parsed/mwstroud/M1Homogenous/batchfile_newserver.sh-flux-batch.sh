#!/bin/bash
#FLUX: --job-name=carnivorous-eagle-2590
#FLUX: --urgency=16

mpirun nrniv -mpi -python run_network.py config.json #srun
