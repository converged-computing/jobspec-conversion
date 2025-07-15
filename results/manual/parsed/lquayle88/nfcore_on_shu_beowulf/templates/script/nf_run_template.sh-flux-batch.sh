#!/bin/bash
#FLUX: --job-name=pipeline_name
#FLUX: --priority=16

export NXF_OPTS='-Xms1g -Xmx2g'
export NXF_SINGULARITY_CACHEDIR='/path/to/singularity_cache/.singularity'

module purge
module load miniconda
source activate nf_env
export NXF_OPTS="-Xms1g -Xmx2g"
export NXF_SINGULARITY_CACHEDIR="/path/to/singularity_cache/.singularity"
NF_PROJECT="/path/to/project/yyyy_mm_dd_project_name"
WORK_DIR="${NF_PROJECT}/results/nf_work"
PARAM_DIR="${NF_PROJECT}/src/nf_params"
CONF_DIR="${NF_PROJECT}/src/nf_config"
nextflow run nf-core/pipeline \
-r version \
-profile profile \
-work-dir $WORK_DIR \
-params-file ${PARAM_DIR}/nf-params.json
