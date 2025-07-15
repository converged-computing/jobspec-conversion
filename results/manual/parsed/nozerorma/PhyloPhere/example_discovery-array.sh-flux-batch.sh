#!/bin/bash
#FLUX: --job-name=nfct-discovery-array
#FLUX: -c=10
#FLUX: --priority=16

DATE_WITH_TIME=`date "+%Y%m%d-%H%M%S"`
TRAIT_DIR="/my/trait/dir"
RESULTS_DIR="/my/result/dir/${DATE_WITH_TIME}"
TOWER_TOKEN="mytowertoken"
FILE_INDEX=$(($SLURM_ARRAY_TASK_ID - 1))
TRAIT_FILES=($(ls $TRAIT_DIR/**/*.tab))
TRAIT_FILE=${TRAIT_FILES[$FILE_INDEX]}
module load Nextflow
nextflow run main.nf -with-singularity -with-tower -profile singularity \
    --accessToken $TOWER_TOKEN \
    --ct_tool discovery \
    --traitfile $TRAIT_FILE \
    --outdir $RESULTS_DIR \
    --maxbgmiss "2" \
    --maxfgmiss "2"  \
    --maxmiss "2" \
    --patterns "1,2,3,4"
