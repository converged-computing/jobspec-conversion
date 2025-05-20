#!/bin/bash -l

# Flux directives to request resources
#flux: --job-name=cnn
#flux: -t 00:30:00
#flux: -N 10
#flux: --tasks-per-node=1
#flux: -c 12
#flux: -g 1
#flux: -o m10.out
#flux: -e m10.err

# Account/Project information is site-specific in Flux.
# This is a placeholder; actual directive may vary (e.g., #flux: --setattr=system.project=c24)
# or it might be handled via environment variables or user defaults.
# #flux: option account=c24 (syntax depends on site configuration)

# Load necessary modules
module load daint-gpu
module load PyTorch

# Set environment variables
# FLUX_TASK_CPUS is set by Flux based on the -c option (cores per task)
export OMP_NUM_THREADS=${FLUX_TASK_CPUS:-12}
export NCCL_DEBUG=INFO
export NCCL_IB_HCA=ipogif0
export NCCL_IB_CUDA_SUPPORT=1

# Execute the application
# With the above Flux directives, 10 tasks will be launched (1 per node).
# Each task will execute the following command.
python main.py