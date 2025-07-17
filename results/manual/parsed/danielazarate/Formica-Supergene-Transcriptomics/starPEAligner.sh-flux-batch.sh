#!/bin/bash
#FLUX: --job-name=starAlign-log
#FLUX: --queue=intel
#FLUX: -t=28800
#FLUX: --urgency=16

date
cd $SLURM_SUBMIT_DIR
module load star
STAR_INDEX=/rhome/danielaz/bigdata/transcriptomics/starIndex
DIR=/rhome/danielaz/bigdata/transcriptomics/raw_fastq
STAR --runThreadN 12 \
--readFilesIn PLACEHOLDER.forward.paired,PLACEHOLDER.foward.unpaired PLACEHOLDER.reverse.paired,PLACEHOLDER.reverse.paired \
--genomeDir ${STAR_INDEX} \
--outSAMtype BAM SortedByCoordinate \
--outFileNamePrefix PLACEHOLDER.map \
--outSAMunmapped Within
