#!/bin/bash
#FLUX: --job-name=test_julia
#FLUX: -N=4
#FLUX: --queue=main
#FLUX: -t=14400
#FLUX: --urgency=16

srun julia mpi_experiment.jl > /cfs/klemming/home/e/emilwa/Private/slurm_output12.txt 2> /cfs/klemming/home/e/emilwa/Private/slurm_stderr12.txt
