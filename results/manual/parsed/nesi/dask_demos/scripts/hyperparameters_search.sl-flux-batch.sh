#!/bin/bash
#FLUX: --job-name=pusheena-gato-7070
#FLUX: -c=80
#FLUX: --queue=milan
#FLUX: -t=600
#FLUX: --urgency=16

export PYTHONNOUSERSITE='1'
export DASK_DISTRIBUTED__WORKER__MEMORY__TARGET='False'
export DASK_DISTRIBUTED__WORKER__MEMORY__SPILL='False'
export DASK_DISTRIBUTED__WORKER__MEMORY__PAUSE='0.80'
export DASK_DISTRIBUTED__WORKER__MEMORY__TERMINATE='0.95'

module purge && module load Miniconda3/22.11.1-1
source $(conda info --base)/etc/profile.d/conda.sh
export PYTHONNOUSERSITE=1
conda deactivate
conda activate ./venv
export DASK_DISTRIBUTED__WORKER__MEMORY__TARGET=False
export DASK_DISTRIBUTED__WORKER__MEMORY__SPILL=False
export DASK_DISTRIBUTED__WORKER__MEMORY__PAUSE=0.80
export DASK_DISTRIBUTED__WORKER__MEMORY__TERMINATE=0.95
python scripts/hyperparameters_search.py
