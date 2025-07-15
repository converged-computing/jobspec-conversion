#!/bin/bash
#FLUX: --job-name=HPRC-asm-batch2
#FLUX: -c=4
#FLUX: --queue=high_priority
#FLUX: -t=259200
#FLUX: --priority=16

export TOIL_SLURM_ARGS='--time=3-0:00 --partition=high_priority'

sample_file=$1
sample_id=$(awk -F ',' -v task_id=${SLURM_ARRAY_TASK_ID} 'NR>1 && NR==task_id+1 {print $1}' "${sample_file}")
if [ -z "${sample_id}" ]; then
    echo "Error: Failed to retrieve a valid sample ID. Exiting."
    exit 1
fi
echo "${sample_id}"
mkdir -p ${sample_id}
cd ${sample_id}
mkdir assembly_logs 
mkdir analysis
SINGULARITY_CACHEDIR=`pwd`/outputs/cache/.singularity/cache 
MINIWDL__SINGULARITY__IMAGE_CACHE=`pwd`/outputs/cache/.cache/miniwdl 
export TOIL_SLURM_ARGS="--time=3-0:00 --partition=high_priority"
toil-wdl-runner \
    --jobStore ./assembly_bigstore \
    --batchSystem slurm \
    --batchLogsDir ./assembly_logs \
    /private/home/juklucas/github/hpp_production_workflows/assembly/wdl/workflows/trio_hifiasm_assembly_cutadapt_multistep.wdl \
    ../hifiasm_input_jsons/${sample_id}_hifiasm.json \
    --outputDirectory analysis/assembly \
    --outputFile ${sample_id}_hifiasm_outputs.json \
    --runLocalJobsOnWorkers \
    --retryCount 0 \
    --disableProgress \
    2>&1 | tee log.txt
wait
echo "Done."
