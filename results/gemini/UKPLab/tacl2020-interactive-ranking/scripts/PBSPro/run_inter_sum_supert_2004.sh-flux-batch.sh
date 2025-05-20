#!/bin/bash

# Flux job script equivalent for intsum_sup_04

# Job name
#flux: --job-name=intsum_sup_04

# Output file
#flux: --output=flux_intersumsup2004_output.log

# Error file
#flux: --error=flux_intersumsup2004_err.log

# Request resources and set limits
#flux: --time=72:00:00
#flux: -N 1                                 # Number of nodes
#flux: -n 1                                 # Total number of tasks (for a single OpenMP/threaded application)
#flux: -c 24                                # Number of CPUs (cores) per task
#flux: --mem=128G                           # Memory requirement (e.g., per node or per job, Flux will allocate appropriately)

# Set OpenMP environment variable to use the allocated cores
# FLUX_TASK_CPUS is set by Flux to the number of cpus allocated to this task (controlled by -c option)
export OMP_NUM_THREADS=${FLUX_TASK_CPUS:-24}

# Load required modules
module load lang/python/anaconda/pytorch

# We might need to add the global paths to our code to the pythonpath. Also set the data directories globally.
cd /work/es1595/text_ranking_bayesian_optimisation

# Run the script using heuristics only and no interactions.
#python -u stage1_active_pref_learning.py H 0 duc04_supert_H "[random]" . 24 DUC2004 0 supert

#  run the script for each DUC dataset with GPPL-IMP, GPPL-UNPA, GPPL-EIG, GPPL-Random, BT-Random.
python -