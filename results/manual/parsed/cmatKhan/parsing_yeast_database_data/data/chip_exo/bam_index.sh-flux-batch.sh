#!/bin/bash
#FLUX: --job-name=bam_index
#FLUX: -t=1800
#FLUX: --priority=16

eval $(spack load --sh samtools@1.13)
lookup="$1"
BAM_FILE=$(sed -n "${SLURM_ARRAY_TASK_ID}p" $lookup)
samtools index $BAM_FILE
echo "BAM file $BAM_FILE indexed successfully."
