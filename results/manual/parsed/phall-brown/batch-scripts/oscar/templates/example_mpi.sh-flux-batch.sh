#!/bin/bash
#FLUX: --job-name=confused-despacito-2331
#FLUX: -N=4
#FLUX: --queue=batch
#FLUX: -t=86400
#FLUX: --urgency=16

module load hpcx-mpi/4.1.5rc2s
EXAMPLE_VARIABLE="Hello!"
echo $EXAMPLE_VARIABLE
srun --mpi=pmix echo $EXAMPLE_VARIABLE 
