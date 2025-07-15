#!/bin/bash
#FLUX: --job-name=hello-peanut-9653
#FLUX: -t=600
#FLUX: --urgency=16

module load system py-globus-cli/1.9.0_py36
if [ $# -ne 3 ]; then
    echo 'ERROR!  The number of arguments should be only 3.'
    exit 1
fi
SOURCE_GLOBUS_PATH=$1
DEST_GLOBUS_PATH=$2
OUTPUT_JOB_FILE=$3
output=$(globus whoami >/dev/null 2>&1)
output_code=$?
if [ $output_code -ne 0 ]; then
    echo 'ERROR!  Not logged in to Globus'
    exit 1
fi
output=$(globus transfer ${SOURCE_GLOBUS_PATH} ${DEST_GLOBUS_PATH} \
    --recursive --notify on --skip-activation-check \
    --jmespath 'task_id' --format=UNIX \
    2>&1 1>${OUTPUT_JOB_FILE})
output_code=$?
if [ $output_code -ne 0 ]; then
    echo 'ERROR: The transfer of data in could not be started.'
    echo $output
    exit 1
fi
exit 0
