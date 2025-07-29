#!/bin/bash
#FLUX: --job-name=save_evecs
#FLUX: -c=12
#FLUX: --queue=huce_cascade
#FLUX: -t=120
#FLUX: --urgency=16

echo "Activating python environment"
module load Anaconda3/5.0.1-fasrc01
source activate ~/python/miniconda/envs/TROPOMI_inversion
echo "Activated ${CONDA_PREFIX}"
DATA_DIR=${3}
SUFFIX=${10}
OPT_BC=${5}
if [[ ${OPT_BC} == "True" ]]; then
  SUFFIX="_bc${SUFFIX}"
fi
rm -rf ${DATA_DIR}/evecs_dask_worker${SUFFIX}/
echo "Initiating script"
python_dir=$(dirname `pwd`)
python -u ${python_dir}/python/generate_evecs.py ${@}
rm -rf ${DATA_DIR}/evecs_dask_worker${SUFFIX}/
