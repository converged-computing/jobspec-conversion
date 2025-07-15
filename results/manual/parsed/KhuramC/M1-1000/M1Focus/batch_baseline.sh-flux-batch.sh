#!/bin/bash
#FLUX: --job-name=goodbye-soup-3611
#FLUX: --priority=16

START=$(date)
echo "Started running at $START."
mpirun nrniv -mpi -python run_network.py simulation_config_baseline.json #srun
END=$(date)
echo "Done running simulation at $END"
