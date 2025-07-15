#!/bin/bash
#FLUX: --job-name=bumfuzzled-poodle-0106
#FLUX: -t=300
#FLUX: --priority=16

module purge  > /dev/null 2>&1
module load GCC/10.3.0  OpenMPI/4.1.1 TensorFlow/2.6.0-CUDA-11.3.1
source scikit-venv/bin/activate
python scikit-learn-kebnekaise.py
