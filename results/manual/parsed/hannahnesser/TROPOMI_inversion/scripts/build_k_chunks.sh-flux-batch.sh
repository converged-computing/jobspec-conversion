#!/bin/bash
#FLUX: --job-name=red-banana-6163
#FLUX: --urgency=16

CHUNK="${SLURM_ARRAY_TASK_ID}"
DATA_DIR=${6}
echo "Activating python environment"
module load Anaconda3/5.0.1-fasrc01
source activate ~/python/miniconda/envs/TROPOMI_inversion
echo "Activated ${CONDA_PREFIX}"
rm -rf ${DATA_DIR}/dask-worker-space-${CHUNK}
echo "Initiating script"
python_dir=$(dirname `pwd`)
python -u ${python_dir}/python/build_k.py ${CHUNK} ${@}
rm -rf ${DATA_DIR}/dask-worker-space-${CHUNK}
