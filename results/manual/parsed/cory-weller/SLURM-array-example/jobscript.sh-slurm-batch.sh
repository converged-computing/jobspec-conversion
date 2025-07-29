#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=20G
#SBATCH --time=02:00:00
#SBATCH --constraint=ntasks-per-node=4

PARAMETER_FILE='sample_ids.txt'
BWA_INDEX='path/to/index_base'
SAMPLE=$(sed -n ${SLURM_ARRAY_TASK_ID}p ${PARAMETER_FILE})
FASTQ_1="data/${SAMPLE}_R1_001.fastq.gz"
FASTQ_2="data/${SAMPLE}_R2_001.fastq.gz"
module load bwa
bwa mem ${BWA_INDEX} $ ${FASTQ_1} ${FASTQ_2} > ${SAMPLE}.sam
