#!/bin/bash
#FLUX: --job-name=bricky-chip-9122
#FLUX: --priority=16

source $HOME/.bashrc.ext
cd $SLURM_SUBMIT_DIR
path_to_scripts=$PWD
time srun -n 12 python-mpi ${path_to_scripts}/example/test/simple_app.py \
    -inifile ${path_to_scripts}/examples/inifiles/simple_parameters.py -tag run_0
