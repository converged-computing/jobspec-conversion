#!/bin/bash
#FLUX: --job-name=autopytorch
#FLUX: -t=90000
#FLUX: --urgency=16

module load CUDA
module load impi/2021.7.0
srun python3 main.py --config automl_config --mh autopytorch --target conso_rte --MPI --save_dir autopytorch --filename dataset/data.csv
exit 1
