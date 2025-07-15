#!/bin/bash
#FLUX: --job-name=dinosaur-gato-9865
#FLUX: --priority=16

SAMP=$(sed -n ${SLURM_ARRAY_TASK_ID}'{p;q}' ../accessory_files/Samples.txt)
SUF=$(sed -n ${SLURM_ARRAY_TASK_ID}'{p;q}' ../accessory_files/Sample_Suffixes.txt)
PRE=$(sed -n ${SLURM_ARRAY_TASK_ID}'{p;q}' ../accessory_files/Sample_Prefixes.txt)
DATAB="../../Data/WGS/"
OUTD="../../Output/WGS/reference_refinement/"
module load NGmerge/0.2-fasrc01
NGmerge -1 ${DATAB}raw_reads/${PRE}_${SAMP}${SUF}_R1_001.fastq.gz -2 ${DATAB}raw_reads/${PRE}_${SAMP}${SUF}_R2_001.fastq.gz -a -v -o ${OUTD}work/${SAMP}.trimmed
module load bwa/0.7.15-fasrc02
bwa mem -M -t 1 -R "@RG\tID:HJ25MBGXC\tSM:${SAMP}\tPL:ILLUMINA" ../accessory_files/orig_w303_ref/w303_ref ${OUTD}work/${SAMP}.trimmed_1.fastq.gz ${OUTD}work/${SAMP}.trimmed_2.fastq.gz > ${OUTD}work/${SAMP}.sam 2> ${OUTD}logs/${SAMP}.bwa.log
module load jdk/1.8.0_45-fasrc01
PICARD_HOME=/n/sw/fasrcsw/apps/Core/picard/2.9.0-fasrc01
java -Xmx4g -XX:ParallelGCThreads=1 -jar $PICARD_HOME/picard.jar SortSam I=${OUTD}work/${SAMP}.sam O=${OUTD}work/${SAMP}.sorted.bam SORT_ORDER=coordinate CREATE_INDEX=true
java -Xmx4g -XX:ParallelGCThreads=1 -jar $PICARD_HOME/picard.jar MarkDuplicates I=${OUTD}work/${SAMP}.sorted.bam O=${OUTD}work/${SAMP}.dedup.bam METRICS_FILE=${OUTD}work/${SAMP}.dedup_metrics.txt REMOVE_DUPLICATES=false TAGGING_POLICY=All 2> ${OUTD}logs/${SAMP}_dedup.log
java -Xmx4g -XX:ParallelGCThreads=1 -jar $PICARD_HOME/picard.jar SortSam I=${OUTD}work/${SAMP}.dedup.bam O=${OUTD}work/${SAMP}.final.bam SORT_ORDER=coordinate CREATE_INDEX=true 2> ${OUTD}logs/${SAMP}_final_sorting.log
java -Xmx4g -XX:ParallelGCThreads=1 -jar $PICARD_HOME/picard.jar ValidateSamFile I=${OUTD}work/${SAMP}.final.bam O=${OUTD}work/${SAMP}.validate.txt MODE=SUMMARY 2> ${OUTD}logs/${SAMP}_validate.log
