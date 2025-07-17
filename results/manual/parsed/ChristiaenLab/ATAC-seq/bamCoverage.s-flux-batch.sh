#!/bin/bash
#FLUX: --job-name=bowtie
#FLUX: -t=3600
#FLUX: --urgency=16

module purge
module load deeptools/intel/2.4.2
RUNDIR=/scratch/kaw504/atacCiona/atac/bam
cd $RUNDIR
sample=$(awk "NR==${SLURM_ARRAY_TASK_ID} {print \$1}" file_name.txt)
bamCoverage -of bigwig -o ${sample}.bw -b ${sample}_q30_rmdup_KhM0_sorted.bam --ignoreDuplicates -p 20 --minMappingQuality 30 --centerReads -ignore mitochondrion_genome --normalizeUsingRPKM -bs 10
exit 0;
