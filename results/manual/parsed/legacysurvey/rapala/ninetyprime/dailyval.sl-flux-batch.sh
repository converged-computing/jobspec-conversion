#!/bin/bash
#FLUX: --job-name=stinky-animal-5568
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR   # optional, since this is the default behavior
srun -n 1 python detchar.py -n -d ~/bok/BOK_Raw/ -l basslogs -u "201711*" 
