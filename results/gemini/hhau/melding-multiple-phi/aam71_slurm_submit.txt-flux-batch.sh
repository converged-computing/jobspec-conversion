#!/bin/bash

# Flux Job Specification

# Job name
#flux: --job-name=aam71-fullmeld

# Wall-clock time limit
#flux: --time=34:00:00

# Resource request: 1 task, 30 cores for that task, on 1 node.
#flux: -N 1
#flux: -n 1
#flux: -c 30

# Memory request for the job (effectively for the single task)
# Based on the SLURM script comment "Each task is allocated 5980M (skylake)"
#flux: --mem=5980M

# Account and queue (partition in SLURM terms)
#flux: --account=mrc-bsu-sl2-cpu
#flux: --queue=skylake

## Section 2: Modules

# All scripts should include the first three lines.
. /etc/profile.d/modules.sh                # Leave this line (enables the module command)
module purge                               # Removes all modules still loaded
module load rhel7/default-peta4            # REQUIRED - loads the basic environment

# Load the latest R version.
module load r-3.6.0-gcc-5.4.0-bzuuksv
module load jags-4.3.0-gcc-5.4.0-4z5shby

#! Insert additional module load commands after this line if needed:

## - - - - - - - - - - -

## Section 3: Run your application

CMD="make"

###############################################################
### Job Information Echoing (Flux equivalents)              ###
###############################################################

JOBID=${FLUX_JOB_ID}

echo -e "JobID: $JOBID\n======"
echo "Time: $(date)"

# FLUX_JOB_NUM_NODES should be set by Flux. Default to 1 if not.
# FLUX_HOSTFILE lists allocated hostnames.
num_nodes=${FLUX_JOB_NUM_NODES:-1}
if [ "${num_nodes}" -gt 1 ]; then
    echo "Running on nodes:"
    if [ -n "$FLUX_HOSTFILE" ]; then
        sort -u "$FLUX_HOSTFILE"
    else
        # This case should ideally not happen for multi-node jobs with Flux
        echo "Node list unavailable via FLUX_HOSTFILE. Primary host: $(hostname)"
    fi
else
    echo "Running on node: $(hostname)"
fi

echo "Current directory: $(pwd)"

# Set OMP_NUM_THREADS to the number of cores allocated to the task.
# FLUX_TASK_NCORES provides this value within the task environment.
# Default to the requested 30 if FLUX_TASK_NCORES is not set for some reason.
export OMP_NUM_THREADS=${FLUX_TASK_NCORES:-30}

# FLUX_NTASKS should be set by Flux based on the -n option.
num_tasks=${FLUX_NTASKS:-1}

echo -e "\nNum tasks = ${num_tasks}, Num nodes = ${num_nodes}, OMP_NUM_THREADS = $OMP_NUM_THREADS"
echo -e "\nExecuting command:\n==================\n$CMD\n"

eval $CMD