#!/bin/bash
#flux: -N 1                # Request 1 node
#flux: -n 1                # Request 1 task for the entire job
#flux: -c 16               # Request 16 cores for that single task
#flux: --mem=650G          # Request 650G total memory for the job (on the allocated node)
#flux: --time-limit=4h0m0s # Request 4 hours walltime
#flux: -q overflow         # Request the 'overflow' queue

# Activate conda environment
source /labs/hulab/stark_conda/bin/activate
conda activate base_pytorch

echo "JOB START"

# Check NVIDIA GPU status (if available on the allocated node)
# Note: GPUs are not explicitly requested in this script.
# If your application requires GPUs, add #flux: -g <count> or #flux: --gpus-per-task=<count>
nvidia-smi

# Execute the main application
python make_whole_data.py