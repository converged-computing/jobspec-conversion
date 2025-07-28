#!/bin/bash
#FLUX: --job-name=test
#FLUX: -t=18000
#FLUX: --urgency=16

export OMP_NUM_THREADS='4'

export OMP_NUM_THREADS=4
module load intel-oneapi/2022.1.0
module load daint-gpu/21.09
module load cudatoolkit/21.3_11.2
module swap gcc gcc/9.3.0
cd ./tests/3-localtemp/ ; srun -n $SLURM_NTASKS ../../bin/runKMC parameters.txt
