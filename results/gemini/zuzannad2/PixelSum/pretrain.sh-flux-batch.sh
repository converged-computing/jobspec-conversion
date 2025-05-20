#!/bin/bash
# Flux directives for resource requests:
#FLUX: --job-name=pretrain-pixel
#FLUX: -N 1                               # Number of nodes
#FLUX: -n 1                               # Total number of tasks for the job
#FLUX: --cores=48                         # Total number of CPU cores for the job (allocated to the single task)
#FLUX: --gpus=1                           # Total number of GPUs for the job (allocated to the single task)
#FLUX: --mem=70000M                       # Total memory for the job
#FLUX: -t 75:00:00                        # Walltime for the job (75 hours)
#FLUX: --queue=gpu                        # Assuming 'gpu' is the corresponding queue name for the Slurm partition 'gpu'.
                                          # The A100 GPU type specificity is assumed to be handled by this queue
                                          # or by system configuration. If more explicit control is needed and supported,
                                          # a --requires directive might be used, e.g., --requires=type:a100

nvidia-smi

export ENCODER="Team-PIXEL/pixel-base"