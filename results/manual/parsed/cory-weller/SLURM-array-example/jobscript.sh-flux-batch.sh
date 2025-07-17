#!/bin/bash
#FLUX: --job-name=red-pancake-1024
#FLUX: --queue=norm
#FLUX: -t=7200
#FLUX: --urgency=16

PARAMETER_FILE='sample_ids.txt'
BWA_INDEX='path/to/index_base'
SAMPLE=$(sed -n ${SLURM_ARRAY_TASK_ID}p ${PARAMETER_FILE})
FASTQ_1="data/${SAMPLE}_R1_001.fastq.gz"
FASTQ_2="data/${SAMPLE}_R2_001.fastq.gz"
module load bwa
bwa mem ${BWA_INDEX} $ ${FASTQ_1} ${FASTQ_2} > ${SAMPLE}.sam
