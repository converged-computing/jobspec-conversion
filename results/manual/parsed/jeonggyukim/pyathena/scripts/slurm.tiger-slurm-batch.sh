#!/bin/bash
#SBATCH --job-name=do_tasks
#SBATCH --output=do_tasks_%j.out
#SBATCH --error=do_tasks_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=20
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --partition=shared
#SBATCH --constraint=ntasks-per-node=28

export MATPLOTLIBRC='$HOME/.config/matplotlib'
export TERM='xterm-256color'
export PATH='$HOME/miniconda3/bin:$HOME/local/bin:$PATH'
export PYTHONSTARTUP='$HOME/.pythonrc.py'
export PYTHONPATH='$PYTHONPATH:/tigress/jk11/slug2/'

NPROCS=20
MODULE="pyathena.tigress_ncr.do_tasks"
export MATPLOTLIBRC="$HOME/.config/matplotlib"
export TERM="xterm-256color"
export PATH="$HOME/miniconda3/bin:$HOME/local/bin:$PATH"
export PYTHONSTARTUP="$HOME/.pythonrc.py"
export PYTHONPATH="$PYTHONPATH:/tigress/jk11/slug2/"
module load intel-mpi
echo "Starting:"
srun -n $NPROCS --mpi=pmi2 python -m $MODULE
date
echo "do_tasks finished"
