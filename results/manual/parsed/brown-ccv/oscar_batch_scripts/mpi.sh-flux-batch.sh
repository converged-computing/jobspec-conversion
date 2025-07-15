#!/bin/bash
#FLUX: --job-name=outstanding-cherry-5457
#FLUX: -t=3600
#FLUX: --priority=16

srun --mpi=pmix ./MyMPIProgram
