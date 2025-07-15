#!/bin/bash
#FLUX: --job-name=primal-test
#FLUX: -t=14400
#FLUX: --priority=16

module purge
module load anaconda
module load boost/1.64.0
module load cuda/9.0.176 cudnn/cuda-9.0_7.4
source activate 571project
python -u turtlebot3.py --alg cbs --no-gui --n-tests 10
