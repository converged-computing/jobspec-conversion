#!/bin/bash
#SBATCH --job-name=1dj7B00
#SBATCH --output=meld.log
#SBATCH --nodes=1
#SBATCH --ntasks=30
#SBATCH --cpus-per-task=1
#SBATCH --gpus-per-task=1
#SBATCH --mem-per-cpu=800mb
#SBATCH --time=2-12:00:00

source ~/.load_OpenMM_cuda10             #load OpenMM+Meld
[[ -d Data ]] || python setup_aMeld.py   #check if there is already a Data/, we are continuing a killed simulation, otherwise start new setup_aMeld.py simulation.
if [ -e remd.log ]; then                 #First check if there is a remd.log file, we are continuing a killed simulation
    prepare_restart --prepare-run        #so we need to prepare_restart.
      fi
srun --mpi=pmix  launch_remd --debug     #restart remd simulation
