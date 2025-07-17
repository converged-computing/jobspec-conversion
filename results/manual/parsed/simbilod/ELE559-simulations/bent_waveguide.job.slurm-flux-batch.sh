#!/bin/bash
#FLUX: --job-name=ECE559-bent
#FLUX: -c=4
#FLUX: -t=600
#FLUX: --urgency=16

source /home/ELE559/ELE559.bashrc
echo "My SLURM_ARRAY_JOB_ID is $SLURM_ARRAY_JOB_ID."
echo "My SLURM_ARRAY_TASK_ID is $SLURM_ARRAY_TASK_ID"
echo "Executing on the machine:" $(hostname)
mpirun -np 4 python bent_waveguide.py
