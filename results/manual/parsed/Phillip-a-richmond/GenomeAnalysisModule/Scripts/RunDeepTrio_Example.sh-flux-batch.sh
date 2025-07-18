#!/bin/bash
#FLUX: --job-name=adorable-frito-2866
#FLUX: -c=10
#FLUX: --queue=defq
#FLUX: -t=172800
#FLUX: --urgency=16

export SINGULARITY_CACHEDIR='$PWD'

module load singularity
BIN_VERSION="1.1.0"
ANNOTATEVARIANTS_INSTALL=/mnt/common/WASSERMAN_SOFTWARE/AnnotateVariants/
source $ANNOTATEVARIANTS_INSTALL/opt/miniconda3/etc/profile.d/conda.sh
conda activate $ANNOTATEVARIANTS_INSTALL/opt/AnnotateVariantsEnvironment
export SINGULARITY_CACHEDIR=$PWD
singularity pull docker://google/deepvariant:deeptrio-"${BIN_VERSION}"
NSLOTS=$SLURM_CPUS_PER_TASK
cd $SLURM_SUBMIT_DIR
WORKING_DIR=/mnt/scratch/Public/TRAINING/GenomeAnalysisModule/StudentSpaces/Gaku/DeepTrio/
mkdir -p $WORKING_DIR
cd $WORKING_DIR
echo "GRCh38 genome"
GENOME=GRCh38
FASTA_DIR=/mnt/common/DATABASES/REFERENCES/GRCh38/GENOME/
FASTA_FILE=GRCh38-lite.fa
SEQ_TYPE=WGS
BAM_DIR=/mnt/scratch/Public/TRAINING/GenomeAnalysisModule/Files/
OUTPUT_DIR=$WORKING_DIR
FAMILY_ID=Test_Family
PROBAND_ID=Proband_subregion
MOTHER_ID=Mother_subregion
FATHER_ID=Father_subregion
PROBAND_BAM=${PROBAND_ID}.bam
FATHER_BAM=${FATHER_ID}.bam
MOTHER_BAM=${MOTHER_ID}.bam
PROBAND_VCF=${PROBAND_ID}.vcf.gz
FATHER_VCF=${FATHER_ID}.vcf.gz
MOTHER_VCF=${MOTHER_ID}.vcf.gz
PROBAND_GVCF=${PROBAND_ID}.gvcf.gz
FATHER_GVCF=${FATHER_ID}.gvcf.gz
MOTHER_GVCF=${MOTHER_ID}.gvcf.gz
singularity run -B /usr/lib/locale/:/usr/lib/locale/ \
	-B "${BAM_DIR}":"/bamdir" \
	-B "${FASTA_DIR}":"/genomedir" \
	-B "${OUTPUT_DIR}":"/output" \
	docker://google/deepvariant:deeptrio-"${BIN_VERSION}" \
	/opt/deepvariant/bin/deeptrio/run_deeptrio \
  	--model_type=$SEQ_TYPE \
  	--ref="/genomedir/$FASTA_FILE" \
  	--reads_child="/bamdir/$PROBAND_BAM" \
	--reads_parent1="/bamdir/$FATHER_BAM" \
	--reads_parent2="/bamdir/$MOTHER_BAM" \
	--output_vcf_child="/output/$PROBAND_VCF" \
	--output_vcf_parent1="/output/$FATHER_VCF" \
	--output_vcf_parent2="/output/$MOTHER_VCF" \
	--sample_name_child="${PROBAND_ID}" \
	--sample_name_parent1="${FATHER_ID}" \
	--sample_name_parent2="${MOTHER_ID}" \
	--regions "19:1200000-1300000" \
  	--num_shards=$NSLOTS \
	--intermediate_results_dir="/output/intermediate_results_dir" \
	--output_gvcf_child="/output/$PROBAND_GVCF" \
	--output_gvcf_parent1="/output/$FATHER_GVCF" \
	--output_gvcf_parent2="/output/$MOTHER_GVCF" 
/mnt/common/Precision/GLNexus/glnexus_cli -c DeepVariant${SEQ_TYPE} \
        $PROBAND_GVCF \
        $FATHER_GVCF \
        $MOTHER_GVCF \
        --threads $NSLOTS \
        > ${FAMILY_ID}.glnexus.merged.bcf
bcftools view ${FAMILY_ID}.glnexus.merged.bcf | bgzip -c > ${FAMILY_ID}.merged.vcf.gz
