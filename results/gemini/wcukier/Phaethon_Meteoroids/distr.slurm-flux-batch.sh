#!/bin/bash
# FLUX SCRIPT: Defines resources for ONE task of a job array.
# This script should be submitted with Flux's job array mechanism,
# for example:
# flux submit --job-name=distr --job-array=0-999 ./this_script_name.sh

# Resource requests for each task in the array:
#FLUX: -N 1                   # Each task runs on 1 node
#FLUX: -n 1                   # Each task consists of 1 process (worker)
#FLUX: -c 1                   # Each task is allocated 1 core
#FLUX: --mem=1000M            # Each task is allocated 1000MB of memory
#FLUX: -t 03:59:00            # Walltime for each task

# Output and error files for each task.
# %J is the Flux job ID.
# %t is the Flux task ID within the job (for job arrays, 0-indexed).
# The job name "distr" is hardcoded here to match the original Slurm job name.
#FLUX: -o logs/R-distr.%J.o%t
#FLUX: -e logs/R-distr.%J.e%t

# Note: Slurm's --mail-type and --mail-user options do not have direct
# equivalents in #FLUX directives. Mail notifications would typically be
# handled by external mechanisms or site-specific configurations if needed.

# Environment setup (same as original script)
module purge
module load anaconda3/2021.5

# Execute the application
# $FLUX_TASK_ID will be set by Flux for each task in the job array.
# It is the Flux equivalent of Slurm's $SLURM_ARRAY_TASK_ID.
echo "Flux Job ID: $FLUX_JOB_ID, Flux Task ID (array index): $FLUX_TASK_ID"
echo "Running command: python main.py $FLUX_TASK_ID 2 100 2000"

python main.py $FLUX_TASK_ID 2 100 2000