#!/bin/bash
#FLUX: --job-name=tart-mango-4451
#FLUX: --queue=a100_shared
#FLUX: -t=3540
#FLUX: --urgency=16

module load cmake/3.15.3
module load gcc/7.5.0
module load cuda/11.1
srun ./run_Ruiz 
