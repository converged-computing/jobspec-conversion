#!/bin/bash
#FLUX: --job-name=dedup
#FLUX: -n=8
#FLUX: --queue=cpu
#FLUX: -t=259200
#FLUX: --priority=16

echo "begin"
date
BAMDIR=/camp/lab/turnerj/working/Bryony/mouse_adult_xci/allele_specific/data/bs-seq/bams/split_bams
INFILE=$(sed -n "${SLURM_ARRAY_TASK_ID}p" 20190902_bams_to_dedup.txt)
ml purge
ml Bismark
echo "modules loaded are:" 
ml
cd $BAMDIR
deduplicate_bismark --bam $INFILE
echo "end"
date
