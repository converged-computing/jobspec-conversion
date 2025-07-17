#!/bin/bash
#FLUX: --job-name=V1_sim
#FLUX: -n=50
#FLUX: -t=172800
#FLUX: --urgency=16

export HDF5_USE_FILE_LOCKING='FALSE'

START=$(date)
echo "Started running at $START."
export HDF5_USE_FILE_LOCKING=FALSE
unset DISPLAY
mpirun ./components/mechanisms/x86_64/special -mpi -python run_network.py config_long.json True # args: config file, whether use coreneuron
END=$(date)
echo "Done running simulation at $END"
TRIALNAME="long_49"
mkdir ../Analysis/simulation_results/"$TRIALNAME"
cp -a output/. ../Analysis/simulation_results/"$TRIALNAME"
cp -a ecp_tmp/. ../Analysis/simulation_results/"$TRIALNAME"
