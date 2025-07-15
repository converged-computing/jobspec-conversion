#!/bin/bash
#FLUX: --job-name=PA_TI
#FLUX: --queue=gpu
#FLUX: --priority=16

module load anaconda/3.6
source activate pytorch_1.7
module load cuda/10.0.130
module load gnu/5.4.0
module load mvapich2
module load matlab
srun matlab -nodisplay -singleCompThread -r "demo_single_echo"
