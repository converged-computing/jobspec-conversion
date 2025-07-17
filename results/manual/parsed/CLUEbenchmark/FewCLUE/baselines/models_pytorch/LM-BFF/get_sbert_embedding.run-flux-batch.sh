#!/bin/bash
#FLUX: --job-name=hanky-spoon-1059
#FLUX: --queue=normal
#FLUX: --urgency=16

export PATH='$PYTHON_HOME/bin:$PATH'

module rm compiler/rocm/2.9
module load compiler/rocm/4.0.1
PYTHON_HOME=/public/home/cluebenchmark/anaconda3/envs/lm-bff
export PATH=$PYTHON_HOME/bin:$PATH
source ~/anaconda3/bin/activate
conda activate lm-bff
cd ~/lm-bff
srun python test.py
