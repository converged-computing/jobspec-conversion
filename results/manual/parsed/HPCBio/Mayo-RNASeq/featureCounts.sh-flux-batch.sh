#!/bin/bash
#FLUX: --job-name=counts
#FLUX: --priority=16

cd ~/mouse-rnaseq-2020/
module load Subread/2.0.0-IGB-gcc-8.2.0
line=$(sed -n -e "$SLURM_ARRAY_TASK_ID p" src/basenames.txt)
mkdir -p results/featureCounts
echo "start featureCounts"
featureCounts -T 1 -s 2 -g gene_id -t exon \
-o results/featureCounts/${line}_featCounts.txt \
-a data/genome/mouse_chr12.gtf \
results/star/${line}_Aligned.sortedByCoord.out.bam
echo "end featureCounts"
