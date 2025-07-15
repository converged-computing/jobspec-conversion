#!/bin/bash
#FLUX: --job-name=python_sweep
#FLUX: --queue=regular
#FLUX: -t=172800
#FLUX: --priority=16

module purge
module load networkx
module load scikit-learn
module load tqdm
module load GCC
module load ngspice
module load matplotlib
srun python3 src/main.py --production
