#!/bin/bash
#FLUX -J helloWorld                      # name of job
#FLUX -o helloWorld.out                  # name of output file
#FLUX -e helloWorld.err                  # name of error file

# For Flux, it's good practice to explicitly request resources.
# Assuming the Slurm defaults would lead to a single task on a single core on one node:
#FLUX -N 1                               # Request 1 node
#FLUX -n 1                               # Request 1 task (process)
#FLUX --cpus-per-task=1                  # Request 1 CPU core for the task (optional, often default for -n 1)
#FLUX --time=01:00:00                    # Example: Request 1 hour walltime (Slurm would use partition default)
                                         # If no time is specified, Flux might use a short default or require one.
                                         # For a direct translation of an unspecified Slurm time,
                                         # one might omit this and rely on Flux system defaults,
                                         # or set a reasonable default if known.
                                         # Let's omit it to mirror the original's lack of specification.

# Load any software environment module required for app
module load gcc/12.2
module load R/4.2.2

# Run my job
Rscript ../NWSimulation.R