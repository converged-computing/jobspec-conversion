#!/bin/bash
#FLUX: --job-name=one
#FLUX: -N=4
#FLUX: --gpus-per-task=1
#FLUX: --queue=gpu
#FLUX: -t=45000
#FLUX: --priority=16

export PYTHONPATH='/home/arup/miniconda3/envs/meld_conda/lib/python3.9/site-packages/:$PYTHONPATH'

export PYTHONPATH=/home/arup/miniconda3/envs/meld_conda/lib/python3.9/site-packages/:$PYTHONPATH
if [ -e remd.log ]; then                 #First check if there is a remd.log file, we are continuing a killed simulation
    /home/arup/miniconda3/envs/meld_conda/bin/prepare_restart --prepare-run        #so we need to prepare_restart.
fi
srun --mpi=pmix_v3 /home/arup/miniconda3/envs/meld_conda/bin/launch_remd --debug
