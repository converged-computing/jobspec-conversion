#!/bin/bash
#FLUX: --job-name=psipred-array
#FLUX: -n=8
#FLUX: -t=360
#FLUX: --urgency=16

module load compiler/gnu/4.8.0
module load R/3.2.3
code=${HOME}/Phd/script_dev/rfpipeline.sh
data_file="epsnps_${SLURM_ARRAY_TASK_ID}.fasta"
echo ${data_file}
${code} ${data_file}
