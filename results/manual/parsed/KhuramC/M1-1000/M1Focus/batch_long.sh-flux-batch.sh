#!/bin/bash
#FLUX: --job-name=muffled-kerfuffle-8944
#FLUX: --urgency=16

START=$(date)
echo "Started running at $START."
mpirun nrniv -mpi -python run_network.py simulation_config_long.json #srun
END=$(date)
echo "Done running simulation at $END"
