#!/bin/bash
#FLUX: --job-name=mmul_sequential
#FLUX: --queue=exercise_hpc
#FLUX: --urgency=16

module load devtoolset/10 mpi/open-mpi-4.0.5
srun ./heat >> data.txt
