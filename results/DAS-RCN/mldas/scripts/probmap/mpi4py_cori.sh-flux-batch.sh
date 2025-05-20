#!/bin/bash
#FLUX: -N 3
#FLUX: -t 05:00:00
#FLUX: --job-name=prob-multiproc
#FLUX: --output=logs/{{name}}-{{id}}.out
# Note: The Slurm constraint "-C haswell" is translated to "--requires=haswell".
# This assumes "haswell" is a recognized resource property in the Flux environment.
#FLUX: --requires=haswell
# Note: The Slurm queue "-q regular" does not have a direct equivalent in Flux
# and is omitted. Job routing in Flux depends on resource availability and
# local Flux instance configuration (e.g., pools, policies).

# Load necessary modules (same as in Slurm script)
module load pytorch/v1.6.0

# Execute the parallel application using flux run
# -n 96: requests 96 tasks
# -c 2: requests 2 cores per task
# These options map directly from the srun command.
flux run -n 96 -c 2 python $HOME/mldas/mldas/assess.py probmap -c $HOME/mldas/configs/assess.yaml -o $SCRATCH/probmaps --mpi