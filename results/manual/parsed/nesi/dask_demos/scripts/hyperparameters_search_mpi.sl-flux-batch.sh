#!/bin/bash
#FLUX: --job-name=delicious-poo-5518
#FLUX: -n=20
#FLUX: -c=4
#FLUX: -t=600
#FLUX: --urgency=16

export PYTHONNOUSERSITE='1'
export DASK_DISTRIBUTED__WORKER__MEMORY__TARGET='False'
export DASK_DISTRIBUTED__WORKER__MEMORY__SPILL='False'
export DASK_DISTRIBUTED__WORKER__MEMORY__PAUSE='0.80'
export DASK_DISTRIBUTED__WORKER__MEMORY__TERMINATE='0.95'

module purge && module load Miniconda3/22.11.1-1 impi/2021.5.1-GCC-11.3.0
source $(conda info --base)/etc/profile.d/conda.sh
export PYTHONNOUSERSITE=1
conda deactivate
conda activate ./venv
export DASK_DISTRIBUTED__WORKER__MEMORY__TARGET=False
export DASK_DISTRIBUTED__WORKER__MEMORY__SPILL=False
export DASK_DISTRIBUTED__WORKER__MEMORY__PAUSE=0.80
export DASK_DISTRIBUTED__WORKER__MEMORY__TERMINATE=0.95
srun --het-group=0-1 python scripts/hyperparameters_search_mpi.py
