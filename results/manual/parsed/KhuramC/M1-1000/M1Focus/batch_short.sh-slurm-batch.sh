#!/bin/bash
#FLUX: --job-name=M1_H_short
#FLUX: -n=24
#FLUX: -t=172800
#FLUX: --urgency=16

START=$(date)
echo "Started running at $START."
mpirun nrniv -mpi -python run_network.py simulation_config_short.json #srun
END=$(date)
echo "Done running simulation at $END"
