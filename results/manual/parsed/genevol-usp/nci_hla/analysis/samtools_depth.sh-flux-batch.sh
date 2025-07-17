#!/bin/bash
#FLUX: --job-name=SamDepth
#FLUX: -c=8
#FLUX: --queue=long
#FLUX: -t=86400
#FLUX: --urgency=16

SAMPLELIST=${SLURM_SUBMIT_DIR}/sample_ids_t1.txt
SAMPLE=$( awk -v ARRID="$SLURM_ARRAY_TASK_ID" 'FNR==ARRID { print $1 }' $SAMPLELIST )
BED=${SLURM_SUBMIT_DIR}/plot_data/hla.bed
BAM=/media/storage/genevol/vitor/nci/bam_hlamapper/${SAMPLE}_t1/${SAMPLE}.adjusted.bam
OUT=${SLURM_SUBMIT_DIR}/plot_data/coverage_${SAMPLE}.txt
samtools depth -a -m 1000000 -b $BED $BAM > $OUT
