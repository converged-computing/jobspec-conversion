#!/bin/bash
#FLUX: --job-name=gp-fitting
#FLUX: -t=10800
#FLUX: --priority=16

module purge
module load openmpi/<your-mpi-module>
module load anaconda/anaconda3
source ~/.bashrc
conda activate holodeck
CONFIG="./gp_config.ini"
mpiexec python gp_trainer.py "${CONFIG}"
