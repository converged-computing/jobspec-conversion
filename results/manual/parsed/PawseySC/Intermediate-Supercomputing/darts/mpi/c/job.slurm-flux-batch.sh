#!/bin/bash
#FLUX: --job-name=darts-mpi
#FLUX: -t=300
#FLUX: --urgency=16

module swap PrgEnv-cray PrgEnv-intel 
srun --export=all -n 24 darts-mpi
