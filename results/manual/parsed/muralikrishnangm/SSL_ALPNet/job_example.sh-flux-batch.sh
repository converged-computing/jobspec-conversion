#!/bin/bash
#FLUX: --job-name=test_SSL
#FLUX: --queue=debug
#FLUX: -t=7200
#FLUX: --urgency=16

export MIOPEN_USER_DB_PATH='/tmp/my-miopen-cache'
export MIOPEN_CUSTOM_CACHE_DIR='${MIOPEN_USER_DB_PATH}'

unset SLURM_EXPORT_ENV
cd $SLURM_SUBMIT_DIR
export MIOPEN_USER_DB_PATH="/tmp/my-miopen-cache"
export MIOPEN_CUSTOM_CACHE_DIR=${MIOPEN_USER_DB_PATH}
rm -rf ${MIOPEN_USER_DB_PATH}
mkdir -p ${MIOPEN_USER_DB_PATH}
module load cray-python
module load PrgEnv-gnu 
module load amd-mixed/5.4.3 
module load craype-accel-amd-gfx90a
source $PROJWORK/stf006/muraligm/software/miniconda3-frontier/bin/activate
conda activate /lustre/orion/stf006/proj-shared/muraligm/ML/SSL_ALPNet/SSL_ALPNet_frontier39
echo "===============STARTING TIME==============="
date
echo "***************Trying without srun***************"
./examples/train_ssl_abdominal_mri.sh
wait
echo "===============ENDING TIME==============="
date
