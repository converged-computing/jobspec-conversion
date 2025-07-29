#!/bin/bash
#SBATCH --job-name=one
#SBATCH --account=accountname
#SBATCH --output=a_4.log
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gpus-per-task=1
#SBATCH --time=12:30:00
#SBATCH --constraint=ntasks-per-node=4

export PYTHONPATH='/home/arup/miniconda3/envs/meld_conda/lib/python3.9/site-packages/:$PYTHONPATH'

export PYTHONPATH=/home/arup/miniconda3/envs/meld_conda/lib/python3.9/site-packages/:$PYTHONPATH
if [ -e remd.log ]; then                 #First check if there is a remd.log file, we are continuing a killed simulation
    /home/arup/miniconda3/envs/meld_conda/bin/prepare_restart --prepare-run        #so we need to prepare_restart.
fi
srun --mpi=pmix_v3 /home/arup/miniconda3/envs/meld_conda/bin/launch_remd --debug
