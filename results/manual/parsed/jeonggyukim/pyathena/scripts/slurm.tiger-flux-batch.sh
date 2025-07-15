#!/bin/bash
#FLUX: --job-name=do_tasks
#FLUX: --urgency=16

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
