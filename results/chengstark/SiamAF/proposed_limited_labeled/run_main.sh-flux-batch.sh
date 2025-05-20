#!/bin/bash
#FLUX -N 1                             # Number of nodes
#FLUX -n 1                             # Number of tasks (for the script itself)
#FLUX -g 2                             # Total number of GPUs for the job (on the single node)
#FLUX -t 240h                          # Walltime (240 hours)
#FLUX -q overflow                      # Queue/Partition
#FLUX -o /home/zguo30/ppg_ecg_proj/proposed_limited_labeled/slurm_outputs/{id}.out   # Output file, {id} is Flux job ID

# Note on memory: Flux does not have a direct equivalent to Slurm's job-wide '--mem' directive.
# This script assumes that nodes in the 'overflow' queue that can satisfy the 2-GPU request
# will also have at least 230GB of memory available for the job.
# If more explicit memory control is needed, a '--requires' constraint might be necessary
# if the Flux instance has memory defined as a queryable resource (e.g., --requires=mem>=230G).

source /labs/hulab/stark_conda/bin/activate
conda activate base_pytorch

echo "JOB START (Flux Job ID: {id})"

# It's good practice to check GPU allocation within the Flux job as well
if command -v flux >/dev/null 2>&1 && command -v flux_resource >/dev/null 2>&1; then
    echo "Flux allocated GPUs: $(flux resource list -g)"
fi
nvidia-smi

python main.py