#!/bin/bash
#FLUX: --job-name=laghos
#FLUX: --output=laghos.log%j
#FLUX: --error=laghos.log%j
#FLUX: -t 1h0m
#FLUX: -N 4
#FLUX: -n 1
#FLUX: --gpus-per-task=1
# FLUX: Account/Project: CSC322 (In Flux, this is typically set via `flux submit --flags=account=CSC322` or queue configuration)

date
# Assuming $MEMBERWORK is defined in the Flux job environment,
# or will be replaced with an appropriate path.
# Create the target directory if it might not exist
mkdir -p $MEMBERWORK/csc322

# Copy application and data files
# The original script implies ./Laghos is relative to the submission directory.
# We assume the same for the Flux script context.
cp ./Laghos/cuda/laghos $MEMBERWORK/csc322/
cp ./Laghos/data/square01_quad.mesh $MEMBERWORK/csc322/

# Change to the working directory
cd $MEMBERWORK/csc322

# Execute the application using hpcrun for profiling
# The LSF jsrun command was: jsrun -n 1 -a 1 -g 1 hpcrun ...
# This translates to 1 task, requiring 1 GPU.
# Flux directives #FLUX: -n 1 and #FLUX: --gpus-per-task=1 handle this.
# The command is launched directly by Flux.
hpcrun -e nvidia-cuda -e cycles ./laghos -p 0 -m ./square01_quad.mesh -rs 1 -tf 0.75 -pa
```