#!/bin/bash
#FLUX: --job-name=YOUR_JOB_NAME
#FLUX: -N=2
#FLUX: -c=4
#FLUX: --queue=gp1d
#FLUX: -t=7200
#FLUX: --urgency=16

module purge
module load compiler/gnu/4.8.5 nvidia/cuda/10.0 openmpi/3.1.4
srun ./gamer 1>>log 2>&1
