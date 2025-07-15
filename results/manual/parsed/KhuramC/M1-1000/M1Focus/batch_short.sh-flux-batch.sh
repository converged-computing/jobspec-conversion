#!/bin/bash
#FLUX: --job-name=eccentric-peas-6723
#FLUX: --urgency=16

START=$(date)
echo "Started running at $START."
mpirun nrniv -mpi -python run_network.py simulation_config_short.json #srun
END=$(date)
echo "Done running simulation at $END"
