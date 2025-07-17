#!/bin/bash
#FLUX: --job-name=save_k0_monthly
#FLUX: -c=12
#FLUX: --queue=huce_intel
#FLUX: -t=120
#FLUX: --urgency=16

DATA_DIR="${1}"
OUTPUT_DIR="${2}"
CODE_DIR="${3}"
MEMORY_GB=45
echo "Activating python environment"
module load Anaconda3/5.0.1-fasrc01
source activate ~/python/miniconda/envs/TROPOMI_inversion
echo "Activated ${CONDA_PREFIX}"
echo "Initiating script"
python_dir=$(dirname `pwd`)
python -u ${python_dir}/python/generate_k0_monthly.py ${MEMORY_GB} ${DATA_DIR} ${OUTPUT_DIR} ${CODE_DIR}
rm -rf ${OUTPUT_DIR}dask-worker-space
