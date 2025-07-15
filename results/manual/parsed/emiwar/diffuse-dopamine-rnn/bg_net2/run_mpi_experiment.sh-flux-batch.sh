#!/bin/bash
#FLUX: --job-name=dirty-cherry-3730
#FLUX: -N=4
#FLUX: --priority=16

srun julia mpi_experiment.jl > /cfs/klemming/home/e/emilwa/Private/slurm_output12.txt 2> /cfs/klemming/home/e/emilwa/Private/slurm_stderr12.txt
