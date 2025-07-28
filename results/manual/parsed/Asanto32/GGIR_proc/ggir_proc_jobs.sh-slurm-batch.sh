#!/bin/bash
#FLUX: --job-name=gt3x_processing
#FLUX: --queue=RM-shared
#FLUX: -t=36000
#FLUX: --urgency=16

set -x
SINGULARITY_CONTAINER=/ocean/projects/med220004p/shared/data_raw/backup_onprem/adam/ggir_test_ggir_test2_v2.sif 
BASE_DIR=/ocean/projects/med220004p/shared/data_sandbox/ggir_proc/group1/
DIR_TO_PROCESS="${BASE_DIR}/subdir_${SLURM_ARRAY_TASK_ID}"
singularity run --bind ${DIR_TO_PROCESS}:/data --bind ${DIR_TO_PROCESS}:/output ${SINGULARITY_CONTAINER} 
