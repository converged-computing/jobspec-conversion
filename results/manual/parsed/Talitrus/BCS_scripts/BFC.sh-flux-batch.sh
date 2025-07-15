#!/bin/bash
#FLUX: --job-name=joyous-house-5690
#FLUX: --urgency=16

name1=$(sed -n "$SLURM_ARRAY_TASK_ID"p seq_list.txt)
cd ../data/seq
module load BFC
bfc -s 3g -t 16 ${name1}_001.fastq.gz | gzip -1 > ${name1}.corrected.fastq.gz
