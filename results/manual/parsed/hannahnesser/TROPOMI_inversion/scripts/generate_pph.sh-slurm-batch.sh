#!/bin/bash
#FLUX: --job-name=save_pph
#FLUX: -c=10
#FLUX: --queue=huce_cascade
#FLUX: -t=60
#FLUX: --urgency=16

CHUNK="${SLURM_ARRAY_TASK_ID}"
SUFFIX=${11}
DATA_DIR=${3}
OPT_BC=${4}
if [[ ${OPT_BC} == "True" ]]; then
  SUFFIX="_bc${SUFFIX}"
fi
echo "Activating python environment"
module load Anaconda3/5.0.1-fasrc01
source activate ~/python/miniconda/envs/TROPOMI_inversion
echo "Activated ${CONDA_PREFIX}"
rm -rf ${DATA_DIR}/pph_dask_worker${SUFFIX}_${CHUNK}/
echo "Initiating script"
python_dir=$(dirname `pwd`)
python -u ${python_dir}/python/generate_pph.py ${CHUNK} ${@}
rm -rf ${DATA_DIR}/pph_dask_worker${SUFFIX}_${CHUNK}/
