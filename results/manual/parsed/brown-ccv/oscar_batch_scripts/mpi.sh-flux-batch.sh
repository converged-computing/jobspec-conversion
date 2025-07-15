#!/bin/bash
#FLUX: --job-name=adorable-frito-2242
#FLUX: -t=3600
#FLUX: --urgency=16

srun --mpi=pmix ./MyMPIProgram
