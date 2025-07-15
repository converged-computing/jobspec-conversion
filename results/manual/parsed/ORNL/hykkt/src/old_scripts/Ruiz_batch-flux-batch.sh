#!/bin/bash
#FLUX: --job-name=doopy-leopard-8924
#FLUX: --priority=16

module load cmake/3.15.3
module load gcc/7.5.0
module load cuda/11.1
srun ./run_Ruiz 
