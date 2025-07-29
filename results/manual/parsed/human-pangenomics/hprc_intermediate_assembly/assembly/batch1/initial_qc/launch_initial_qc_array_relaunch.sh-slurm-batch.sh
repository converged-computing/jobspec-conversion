#!/bin/bash
#FLUX: --job-name=HPRC-qc-batch1
#FLUX: -c=4
#FLUX: --queue=high_priority
#FLUX: -t=86400
#FLUX: --urgency=16

export SINGULARITY_CACHEDIR='`pwd`/outputs/cache/.singularity/cache '
export MINIWDL__SINGULARITY__IMAGE_CACHE='`pwd`/outputs/cache/.cache/miniwdl '
export TOIL_SLURM_ARGS='--time=3-0:00 --partition=high_priority'
export TOIL_COORDINATION_DIR='/data/tmp'

sample_file=$1
sample_id=$(awk -F ',' -v task_id=${SLURM_ARRAY_TASK_ID} 'NR>1 && NR==task_id+1 {print $1}' "${sample_file}")
if [ -z "${sample_id}" ]; then
    echo "Error: Failed to retrieve a valid sample ID. Exiting."
    exit 1
fi
echo "${sample_id}"
cd ${sample_id}
mkdir -p qc_logs 
export SINGULARITY_CACHEDIR=`pwd`/outputs/cache/.singularity/cache 
export MINIWDL__SINGULARITY__IMAGE_CACHE=`pwd`/outputs/cache/.cache/miniwdl 
export TOIL_SLURM_ARGS="--time=3-0:00 --partition=high_priority"
export TOIL_COORDINATION_DIR=/data/tmp
toil-wdl-runner \
    --jobStore ./qc_bigstore \
    --batchSystem slurm \
    --batchLogsDir ./qc_logs \
    /private/home/juklucas/github/hpp_production_workflows/QC/wdl/workflows/comparison_qc.wdl \
    ../initial_qc/qc_input_jsons/${sample_id}_initial_qc.json \
    --outputDirectory analysis/qc \
    --outputFile ${sample_id}_hifiasm_qc_outputs.json \
    --runLocalJobsOnWorkers \
    --disableProgress true \
    --caching=false \
    2>&1 | tee log.txt
wait
echo "Done."
