#!/bin/bash
#FLUX: --job-name=cryosparc_{{ project_uid }}_{{ job_uid }}
#FLUX: --priority=16

export TMPDIR='/scratch/${USER}/cryosparc/'
export MODULEPATH='/afs/slac/package/singularity/modulefiles'
export RUN_ARGS='{{ run_args }}'

LD_PRELOAD=""
nvidia-smi
echo "CUDA_VISIBLE_DEVICES="${CUDA_VISIBLE_DEVICES}
echo "CRYOSPARC_VERSION="${CRYOSPARC_VERSION}
export TMPDIR="/scratch/${USER}/cryosparc/"
echo "TMPDIR="$TMPDIR
mkdir -p ${TMPDIR}
source /etc/profile.d/modules.sh
export MODULEPATH=/afs/slac/package/singularity/modulefiles
module load cryosparc/${CRYOSPARC_VERSION}
export RUN_ARGS="{{ run_args }}"
{{ worker_bin_path }} run ${RUN_ARGS/--master_hostname ${CRYOSPARC_MASTER_HOSTNAME}/--master_hostname ${CRYOSPARC_API_HOSTNAME}} --ssd "${TMPDIR}"  --ssdquota ${CRYOSPARC_CACHE_QUOTA:-250000} --ssdreserve ${CRYOSPARC_CACHE_FREE:-5000}  > {{ job_log_path_abs }} 2>&1
