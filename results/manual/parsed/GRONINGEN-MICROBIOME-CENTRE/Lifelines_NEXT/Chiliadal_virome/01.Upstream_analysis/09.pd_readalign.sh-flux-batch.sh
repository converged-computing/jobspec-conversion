#!/bin/bash
#FLUX: --job-name=rAssQuality
#FLUX: -c=8
#FLUX: -t=21540
#FLUX: --urgency=16

SAMPLE_LIST=$1
echo ${SAMPLE_LIST}
SAMPLE_ID=$(sed "${SLURM_ARRAY_TASK_ID}q;d" ${SAMPLE_LIST} | cut -d "_" -f1)
echo "SAMPLE_ID=${SAMPLE_ID}"
mkdir -p ${TMPDIR}/${SAMPLE_ID}/ALIGN
module purge
module load Bowtie2
module load SAMtools
module list
bowtie2-build \
        ../SAMPLES/${SAMPLE_ID}/virome_discovery/tidy/${SAMPLE_ID}_extended_viral.fasta \
	${TMPDIR}/${SAMPLE_ID}/ALIGN/${SAMPLE_ID}_vir_ext
bowtie2 \
        --very-sensitive \
        -x ${TMPDIR}/${SAMPLE_ID}/ALIGN/${SAMPLE_ID}_vir_ext \
        -1 ../SAMPLES/${SAMPLE_ID}/clean_reads/${SAMPLE_ID}_dedup_paired_1.fastq.gz \
        -2 ../SAMPLES/${SAMPLE_ID}/clean_reads/${SAMPLE_ID}_dedup_paired_2.fastq.gz \
        --no-unal \
        --threads ${SLURM_CPUS_PER_TASK} \
        -S ${TMPDIR}/${SAMPLE_ID}/ALIGN/${SAMPLE_ID}.sam \
        &> ../SAMPLES/${SAMPLE_ID}/virome_discovery/tidy/paired_to_ext.vir.bowtie2.log
rm ${TMPDIR}/${SAMPLE_ID}/ALIGN/${SAMPLE_ID}*
bowtie2-build \
        ../SAMPLES/${SAMPLE_ID}/virome_discovery/tidy/${SAMPLE_ID}_extended_pruned_viral.fasta \
        ${TMPDIR}/${SAMPLE_ID}/ALIGN/${SAMPLE_ID}_vir_ext_prun
bowtie2 \
        --very-sensitive \
        -x ${TMPDIR}/${SAMPLE_ID}/ALIGN/${SAMPLE_ID}_vir_ext_prun \
        -1 ../SAMPLES/${SAMPLE_ID}/clean_reads/${SAMPLE_ID}_dedup_paired_1.fastq.gz \
        -2 ../SAMPLES/${SAMPLE_ID}/clean_reads/${SAMPLE_ID}_dedup_paired_2.fastq.gz \
        --no-unal \
        --threads ${SLURM_CPUS_PER_TASK} \
        -S ${TMPDIR}/${SAMPLE_ID}/ALIGN/${SAMPLE_ID}.sam \
        &> ../SAMPLES/${SAMPLE_ID}/virome_discovery/tidy/paired_to_ext.prun.vir.bowtie2.log
module purge
