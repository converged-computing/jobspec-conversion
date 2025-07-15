#!/bin/bash
#FLUX: --job-name=persnickety-bits-7420
#FLUX: --priority=16

START=$(date)
echo "Started running at $START."
mpirun nrniv -mpi -python run_network.py simulation_config_short.json #srun
END=$(date)
echo "Done running simulation at $END"
