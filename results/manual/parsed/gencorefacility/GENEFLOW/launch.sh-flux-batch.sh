#!/bin/bash
#FLUX: --job-name=bricky-leader-8688
#FLUX: -c=6
#FLUX: -t=604800
#FLUX: --priority=16

module purge
module load nextflow/23.04.1
run_dir_path=$1
fcid=$2
entry=$3
log_dir="/scratch/gencore/GENEFLOW/alpha/logs/${fcid}/pipeline"
nextflow_command="nextflow \
  -log ${log_dir}/nextflow.log run /home/gencore/SCRIPTS/GENEFLOW/main.nf \
  -c /home/gencore/SCRIPTS/GENEFLOW/nextflow.config \
  --run_dir_path $run_dir_path \
  --trace_file_path ${log_dir}/trace.txt \
  -with-report ${log_dir}/${fcid}_report.html"
if [ ! -z "$entry" ]; then
  nextflow_command="$nextflow_command -entry $entry"
fi
eval $nextflow_command
