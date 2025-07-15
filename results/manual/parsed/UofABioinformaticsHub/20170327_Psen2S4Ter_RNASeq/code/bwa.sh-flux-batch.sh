#!/bin/bash
#FLUX: --job-name=purple-hope-7141
#FLUX: -t=36000
#FLUX: --urgency=16

CORES=16
module load FastQC/0.11.7
module load BWA/0.7.15-foss-2017a
module load SAMtools/1.9-foss-2016b
RRNA=/data/biorefs/rRNA/danio_rerio/bwa/danRer11
PROJROOT=/data/biohub/20170327_Psen2S4Ter_RNASeq/data
TRIMDATA=${PROJROOT}/1_trimmedData
ALIGNDATABWA=${PROJROOT}/4_bwa
mkdir -p ${ALIGNDATABWA}/bam
mkdir -p ${ALIGNDATABWA}/fastq
mkdir -p ${ALIGNDATABWA}/log
mkdir -p ${ALIGNDATABWA}/FastQC
gzip ${ALIGNDATABWA}/fastq/*.fastq
