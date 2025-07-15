#!/bin/bash
#FLUX: --job-name=gassy-cherry-6714
#FLUX: -c=20
#FLUX: --queue=defq
#FLUX: -t=172800
#FLUX: --urgency=16

ANNOTATEVARIANTS_INSTALL=/mnt/common/WASSERMAN_SOFTWARE/AnnotateVariants/
source $ANNOTATEVARIANTS_INSTALL/opt/miniconda3/etc/profile.d/conda.sh
conda activate $ANNOTATEVARIANTS_INSTALL/opt/AnnotateVariantsEnvironment
NSLOTS=$SLURM_CPUS_PER_TASK
WORKING_DIR=/mnt/scratch/Public/TRAINING/GenomeAnalysisModule/StudentSpaces/Sherlock/CaseAnalysis/
mkdir -p $WORKING_DIR
cd $WORKING_DIR
CASE_DIRECTORY=/mnt/scratch/Public/TRAINING/GenomeAnalysisModule/CaseInformation/CaseFiles/Case7/
GENOME_INDEX=/mnt/common/DATABASES/REFERENCES/GRCh38/GENOME/GRCh38-lite.fa
SAMPLE=Case7_proband
FASTQR1=$CASE_DIRECTORY/${SAMPLE}_R1.fastq.gz
FASTQR2=$CASE_DIRECTORY/${SAMPLE}_R2.fastq.gz
bwa mem $GENOME_INDEX \
	-R "@RG\tID:proband\tSM:proband\tPL:illumina" \
	$FASTQR1 \
	$FASTQR2 \
	> ${SAMPLE}.sam
samtools view \
	-@ $NSLOTS \
	-b ${SAMPLE}.sam  \
	-o ${SAMPLE}.bam
samtools sort \
	-@ $NSLOTS \
	${SAMPLE}.bam \
	-o ${SAMPLE}.sorted.bam
samtools index \
	${SAMPLE}.sorted.bam
module load singularity
BIN_VERSION="1.0.0"
singularity pull docker://google/deepvariant:"${BIN_VERSION}"
SAMPLE_BAM=$SAMPLE.sorted.bam
FASTA_DIR=/mnt/common/DATABASES/REFERENCES/GRCh38/GENOME/
FASTA_FILE=GRCh38-lite.fa
OUTPUT_DIR=$WORKING_DIR/${SAMPLE}_DeepVariant
mkdir -p $OUTPUT_DIR
singularity run -B /usr/lib/locale/:/usr/lib/locale/ \
	-B "${WORKING_DIR}":"/bamdir" \
	-B "${FASTA_DIR}":"/genomedir" \
	-B "${WORKING_DIR}":"/output" \
	docker://google/deepvariant:"${BIN_VERSION}" \
  /opt/deepvariant/bin/run_deepvariant \
  --model_type=WGS \
  --ref="/genomedir/$FASTA_FILE" \
  --reads="/bamdir/$SAMPLE_BAM" \
  --output_vcf="/output/${SAMPLE}_DeepVariant.vcf.gz" \
  --num_shards=$SLURM_CPUS_PER_TASK 
SAMPLE=Case7_mother
FASTQR1=$CASE_DIRECTORY/${SAMPLE}_R1.fastq.gz
FASTQR2=$CASE_DIRECTORY/${SAMPLE}_R2.fastq.gz
bwa mem $GENOME_INDEX \
	-R "@RG\tID:mother\tSM:mother\tPL:illumina" \
	$FASTQR1 \
	$FASTQR2 \
	> ${SAMPLE}.sam
samtools view \
	-@ $NSLOTS \
	-b ${SAMPLE}.sam  \
	-o ${SAMPLE}.bam
samtools sort \
	-@ $NSLOTS \
	${SAMPLE}.bam \
	-o ${SAMPLE}.sorted.bam
samtools index \
	${SAMPLE}.sorted.bam
module load singularity
BIN_VERSION="1.0.0"
singularity pull docker://google/deepvariant:"${BIN_VERSION}"
SAMPLE_BAM=$SAMPLE.sorted.bam
FASTA_DIR=/mnt/common/DATABASES/REFERENCES/GRCh38/GENOME/
FASTA_FILE=GRCh38-lite.fa
OUTPUT_DIR=$WORKING_DIR/${SAMPLE}_DeepVariant
mkdir -p $OUTPUT_DIR
singularity run -B /usr/lib/locale/:/usr/lib/locale/ \
	-B "${WORKING_DIR}":"/bamdir" \
	-B "${FASTA_DIR}":"/genomedir" \
	-B "${WORKING_DIR}":"/output" \
	docker://google/deepvariant:"${BIN_VERSION}" \
  /opt/deepvariant/bin/run_deepvariant \
  --model_type=WGS \
  --ref="/genomedir/$FASTA_FILE" \
  --reads="/bamdir/$SAMPLE_BAM" \
  --output_vcf="/output/${SAMPLE}_DeepVariant.vcf.gz" \
  --num_shards=$SLURM_CPUS_PER_TASK 
SAMPLE=Case7_father
FASTQR1=$CASE_DIRECTORY/${SAMPLE}_R1.fastq.gz
FASTQR2=$CASE_DIRECTORY/${SAMPLE}_R2.fastq.gz
bwa mem $GENOME_INDEX \
	-R "@RG\tID:father\tSM:father\tPL:illumina" \
	$FASTQR1 \
	$FASTQR2 \
	> ${SAMPLE}.sam
samtools view \
	-@ $NSLOTS \
	-b ${SAMPLE}.sam  \
	-o ${SAMPLE}.bam
samtools sort \
	-@ $NSLOTS \
	${SAMPLE}.bam \
	-o ${SAMPLE}.sorted.bam
samtools index \
	${SAMPLE}.sorted.bam
module load singularity
BIN_VERSION="1.0.0"
singularity pull docker://google/deepvariant:"${BIN_VERSION}"
SAMPLE_BAM=$SAMPLE.sorted.bam
FASTA_DIR=/mnt/common/DATABASES/REFERENCES/GRCh38/GENOME/
FASTA_FILE=GRCh38-lite.fa
OUTPUT_DIR=$WORKING_DIR/${SAMPLE}_DeepVariant
mkdir -p $OUTPUT_DIR
singularity run -B /usr/lib/locale/:/usr/lib/locale/ \
	-B "${WORKING_DIR}":"/bamdir" \
	-B "${FASTA_DIR}":"/genomedir" \
	-B "${WORKING_DIR}":"/output" \
	docker://google/deepvariant:"${BIN_VERSION}" \
  /opt/deepvariant/bin/run_deepvariant \
  --model_type=WGS \
  --ref="/genomedir/$FASTA_FILE" \
  --reads="/bamdir/$SAMPLE_BAM" \
  --output_vcf="/output/${SAMPLE}_DeepVariant.vcf.gz" \
  --num_shards=$SLURM_CPUS_PER_TASK 
PROBAND_VCF=Case7_proband_DeepVariant.vcf.gz
MOTHER_VCF=Case7_mother_DeepVariant.vcf.gz
FATHER_VCF=Case7_father_DeepVariant.vcf.gz
bcftools merge -0 $PROBAND_VCF \
	$MOTHER_VCF \
	$FATHER_VCF \
       	-o Case7_Merged_Deepvariant.vcf	
bgzip Case7_Merged_Deepvariant.vcf
tabix Case7_Merged_Deepvariant.vcf.gz
