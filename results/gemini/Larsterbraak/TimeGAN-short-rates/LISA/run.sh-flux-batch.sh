#!/bin/bash
#FLUX: -N 1
#FLUX: -t 48:30:00
#FLUX: --gpus-per-node=1  # Translated from Slurm partition "gpu_titanrtx"
                         # If the specific GPU model "titanrtx" needs to be enforced
                         # and is queryable in Flux, you might add:
                         # #FLUX: --requires=gpu_model==titanrtx 
                         # (The exact property name 'gpu_model' and value 'titanrtx'
                         #  depend on the Flux resource configuration.)

# Loading modules
module purge #Unload all loaded modules
module load 2019
module load TensorFlow

echo Running on Lisa System # This message might need updating if not on "Lisa System"

#Copy input file to scratch
#cp $HOME/$NAME "$TMPDIR" # TMPDIR might be different or not set in Flux;
                         # Flux typically provides FLUX_JOB_TMPDIR or similar if needed.

# Execute a python program
python3 $HOME/main.py