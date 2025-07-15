#!/bin/bash
#FLUX: --job-name=boopy-squidward-0867
#FLUX: --urgency=16

START=$(date)
echo "Started running at $START."
mpirun nrniv -mpi -python run_network.py simulation_config_baseline.json #srun
END=$(date)
echo "Done running simulation at $END"
