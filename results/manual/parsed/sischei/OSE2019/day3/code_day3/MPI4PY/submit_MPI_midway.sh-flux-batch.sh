#!/bin/bash
#FLUX: --job-name=adorable-caramel-4308
#FLUX: -N=2
#FLUX: --priority=16

module load Anaconda2
mpirun python bcast.py
