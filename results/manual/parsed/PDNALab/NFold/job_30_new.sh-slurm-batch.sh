#!/bin/bash
#FLUX: --job-name=1dj7B00
#FLUX: -n=30
#FLUX: --gpus-per-task=1
#FLUX: --queue=gpu
#FLUX: -t=216000
#FLUX: --urgency=16

source ~/.load_OpenMM_cuda10             #load OpenMM+Meld
[[ -d Data ]] || python setup_aMeld.py   #check if there is already a Data/, we are continuing a killed simulation, otherwise start new setup_aMeld.py simulation.
if [ -e remd.log ]; then                 #First check if there is a remd.log file, we are continuing a killed simulation
    prepare_restart --prepare-run        #so we need to prepare_restart.
      fi
srun --mpi=pmix  launch_remd --debug     #restart remd simulation
