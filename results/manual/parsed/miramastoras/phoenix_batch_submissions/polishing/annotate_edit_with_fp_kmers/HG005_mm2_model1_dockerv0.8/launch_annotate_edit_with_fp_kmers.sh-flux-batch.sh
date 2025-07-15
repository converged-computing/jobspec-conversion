#!/bin/bash
#FLUX: --job-name=HPRC-GQ_filters-annotate_edit_with_fp_kmers
#FLUX: -c=8
#FLUX: --queue=high_priority
#FLUX: -t=3600
#FLUX: --priority=16

export SINGULARITY_CACHEDIR='`pwd`/../cache/.singularity/cache'
export MINIWDL__SINGULARITY__IMAGE_CACHE='`pwd`/../cache/.cache/miniwdl'
export TOIL_SLURM_ARGS='--time=1:00:00 --partition=high_priority'
export TOIL_COORDINATION_DIR='/data/tmp'

set -ex
sample_file=$1
sample_id=$(awk -F ',' -v task_id=${SLURM_ARRAY_TASK_ID} 'NR>1 && NR==task_id+1 {print $1}' "${sample_file}")
if [ -z "${sample_id}" ]; then
    echo "Error: Failed to retrieve a valid sample ID. Exiting."
    exit 1
fi
echo "${sample_id}"
mkdir -p ${sample_id}
cd ${sample_id}
mkdir -p toil_logs
mkdir -p ./annotate_edit_with_fp_kmers_outputs
export SINGULARITY_CACHEDIR=`pwd`/../cache/.singularity/cache
export MINIWDL__SINGULARITY__IMAGE_CACHE=`pwd`/../cache/.cache/miniwdl
export TOIL_SLURM_ARGS="--time=1:00:00 --partition=high_priority"
export TOIL_COORDINATION_DIR=/data/tmp
toil clean "./jobstore"
set -o pipefail
set +e
time toil-wdl-runner \
    --jobStore "./jobstore" \
    --stats \
    --clean=never \
    --batchSystem single_machine \
    --maxCores "${SLURM_CPUS_PER_TASK}" \
    --batchLogsDir ./toil_logs \
    /private/home/mmastora/progs/hpp_production_workflows/QC/wdl/tasks/annotate_edit_with_fp_kmers.wdl \
    ../annotate_edit_with_fp_kmers_input_jsons/${sample_id}_annotate_edit_with_fp_kmers.json \
    --outputDirectory ./annotate_edit_with_fp_kmers_outputs \
    --outputFile ${sample_id}_annotate_edit_with_fp_kmers_outputs.json \
    --runLocalJobsOnWorkers \
    --retryCount 1 \
    --disableProgress \
    2>&1 | tee log.txt
EXITCODE=$?
set -e
toil stats --outputFile stats.txt "./jobstore"
if [[ "${EXITCODE}" == "0" ]] ; then
    echo "Succeeded."
else
    echo "Failed."
    exit "${EXITCODE}"
fi
