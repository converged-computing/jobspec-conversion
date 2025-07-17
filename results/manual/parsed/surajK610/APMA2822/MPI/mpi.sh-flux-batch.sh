#!/bin/bash
#FLUX: --job-name=MyMPIJob
#FLUX: -N=2
#FLUX: -t=3600
#FLUX: --urgency=16

srun --mpi=pmix_v4 ex1
