#!/bin/bash
#FLUX: --job-name=M1_H_sim
#FLUX: -n=80
#FLUX: -t=172800
#FLUX: --urgency=16

export HDF5_USE_FILE_LOCKING='FALSE'

START=$(date)
echo "Started running at $START."
export HDF5_USE_FILE_LOCKING=FALSE
unset DISPLAY
mpirun nrniv -mpi -python run_network.py config.json #srun
END=$(date)
echo "Done running simulation at $END"
TRIALNAME="baseline_135"
mkdir ../Analysis/simulation_results/"$TRIALNAME"
cp -a output/. ../Analysis/simulation_results/"$TRIALNAME"
cp -a ecp_tmp/. ../Analysis/simulation_results/"$TRIALNAME"
