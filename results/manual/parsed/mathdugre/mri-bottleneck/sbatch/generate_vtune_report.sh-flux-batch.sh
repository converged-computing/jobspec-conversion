#!/bin/bash
#FLUX: --job-name=generate-vtune-summary
#FLUX: --queue=gpu
#FLUX: -t=14400
#FLUX: --urgency=16

set -e
set -u
[[ -z ${SLURM_ARRAY_TASK_ID:+x} ]] && SLURM_ARRAY_TASK_ID=1
SIF_IMG=$1
TAR_FILE=$(sed -n ${SLURM_ARRAY_TASK_ID}p $2)
PARENT_FOLDER=$(dirname $TAR_FILE)
FILENAME=$(basename $TAR_FILE)
EXTRACTED_FOLDER=${FILENAME%%.*}
echo "[INFO] Fixing VTune report: $TAR_FILE"
cd $PARENT_FOLDER
tar xzf $FILENAME
singularity exec --cleanenv \
    -B ~/intel/oneapi/vtune/latest/:/vtune \
    -B $PARENT_FOLDER:$PARENT_FOLDER \
    $SIF_IMG \
    /vtune/bin64/vtune \
    -report summary \
    -r $PARENT_FOLDER/$EXTRACTED_FOLDER \
    -report-output $PARENT_FOLDER/$EXTRACTED_FOLDER.makespan \
    -format csv \
    -csv-delimiter tab
rm -r $EXTRACTED_FOLDER
