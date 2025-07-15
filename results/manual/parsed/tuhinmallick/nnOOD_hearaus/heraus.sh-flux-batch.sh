#!/bin/bash
#FLUX: --job-name=heraus-test1
#FLUX: -t=82800
#FLUX: --priority=16

unset SLURM_EXPORT_ENV
module load python/3.8-anaconda
module load cuda
source activate base
python nnOOD_run_training.py fullres nnOODTrainerDS heraus_png FPI 1
