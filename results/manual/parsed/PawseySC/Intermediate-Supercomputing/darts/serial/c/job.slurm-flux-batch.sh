#!/bin/bash
#FLUX: --job-name=darts-serial
#FLUX: -t=300
#FLUX: --priority=16

module swap PrgEnv-cray PrgEnv-intel 
srun --export=all -n 1 ./darts
