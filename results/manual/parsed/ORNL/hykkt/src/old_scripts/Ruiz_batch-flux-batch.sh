#!/bin/bash
#FLUX: --job-name=cowy-spoon-9462
#FLUX: --urgency=16

module load cmake/3.15.3
module load gcc/7.5.0
module load cuda/11.1
srun ./run_Ruiz 
