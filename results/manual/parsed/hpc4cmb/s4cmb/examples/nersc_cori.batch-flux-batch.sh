#!/bin/bash
#FLUX: --job-name=s4cmbrocks
#FLUX: --queue=debug
#FLUX: -t=300
#FLUX: --urgency=16

source $HOME/.bashrc.ext
cd $SLURM_SUBMIT_DIR
path_to_scripts=$PWD
time srun -n 12 python-mpi ${path_to_scripts}/example/test/simple_app.py \
    -inifile ${path_to_scripts}/examples/inifiles/simple_parameters.py -tag run_0
