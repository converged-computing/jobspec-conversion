#!/bin/bash
#SBATCH --job-name=s4cmbrocks
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:05:00
#SBATCH --partition=debug
#SBATCH --constraint=haswell

source $HOME/.bashrc.ext
cd $SLURM_SUBMIT_DIR
path_to_scripts=$PWD
time srun -n 12 python-mpi ${path_to_scripts}/example/test/simple_app.py \
    -inifile ${path_to_scripts}/examples/inifiles/simple_parameters.py -tag run_0
