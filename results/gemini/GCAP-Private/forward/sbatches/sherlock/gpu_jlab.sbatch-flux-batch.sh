#!/bin/bash
#FLUX: -N 1
#FLUX: -n 1
#FLUX: --gpus-per-task=1

# Script arguments for port and notebook directory
PORT=$1
NOTEBOOK_DIR=$2

# Change to the notebook directory
cd $NOTEBOOK_DIR

# Load required software modules
module load system
module load x11
module load stata
ml py-tensorflow/2.1.0_py36 # 'ml' is often an alias for 'module load'

# Commented out pip install commands from original script
# pip3 install ipython --upgrade --user
# pip3 install pandas --upgrade --user
# pip3 install jupyter --upgrade --user

# Set environment variable for Stata temporary files
STATATMP="/scratch/groups/maggiori/stata_tmp"
export STATATMP

# Launch Jupyter Lab
~/.local/bin/jupyter lab --no-browser --port=$PORT