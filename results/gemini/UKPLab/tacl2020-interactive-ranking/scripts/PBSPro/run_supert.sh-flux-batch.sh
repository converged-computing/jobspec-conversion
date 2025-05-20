#!/bin/sh

# Flux job name
#flux: -N supert

# Flux output file
#flux: -o pbs_supert_output.log

# Flux error file
#flux: -e pbs_supert_err.log

# Flux walltime
#flux: -t 72h

# Flux resource requests:
# Request 1 node.
# Run 1 task in total on this node.
# Allocate 8 CPUs, 4 GPUs, and 24GB of memory to this task.
#flux: -N 1
#flux: -n 1
#flux: --cpus-per-task=8
#flux: --gpus-per-task=4
#flux: --mem-per-task=24G

# Load required modules
module load lang/python/anaconda/pytorch lang/cuda

# Change to the working directory
cd /work/es1595/text_ranking_bayesian_optimisation

# Run the script
python -u obtain_supert_scores.py