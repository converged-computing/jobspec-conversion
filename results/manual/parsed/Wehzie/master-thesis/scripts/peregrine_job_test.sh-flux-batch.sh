#!/bin/bash
#FLUX: --job-name=python_sweep_test
#FLUX: --queue=vulture
#FLUX: -t=60
#FLUX: --priority=16

module purge
module load matplotlib
module load networkx
module load scikit-learn
module load tqdm
module load GCC
module load ngspice
srun python3 src/main.py
