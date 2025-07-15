#!/bin/bash
#FLUX: --job-name=buttery-dog-7223
#FLUX: -c=40
#FLUX: -t=172800
#FLUX: --priority=16

export SINGULARITY_CACHEDIR='$PWD'

module load singularity
BIN_VERSION="1.1.0"
ANNOTATEVARIANTS_INSTALL=annotate_variants_dir
source $ANNOTATEVARIANTS_INSTALL/opt/miniconda3/etc/profile.d/conda.sh
conda activate $ANNOTATEVARIANTS_INSTALL/opt/AnnotateVariantsEnvironment
export SINGULARITY_CACHEDIR=$PWD
singularity pull docker://google/deepvariant:deeptrio-"${BIN_VERSION}"
NSLOTS=$SLURM_CPUS_PER_TASK
cd $SLURM_SUBMIT_DIR
WORKING_DIR=working_dir
mkdir -p $WORKING_DIR
cd $WORKING_DIR
echo "GRCh38 genome"
GENOME=genome_build
FASTA_DIR=fasta_dir
FASTA_FILE=fasta_file
SEQ_TYPE=seq_type
BAM_DIR=$WORKING_DIR
FAMILY_ID=family_id
PROBAND_ID=proband_id
MOTHER_ID=mother_id
FATHER_ID=father_id
PED=$FAMILY_ID.ped
PROBAND_BAM=${PROBAND_ID}_${GENOME}.dupremoved.sorted.bam
FATHER_BAM=${FATHER_ID}_${GENOME}.dupremoved.sorted.bam
MOTHER_BAM=${MOTHER_ID}_${GENOME}.dupremoved.sorted.bam
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
	--sample_name_child="${PROBAND_ID}_${GENOME}" \
	--sample_name_parent1="${FATHER_ID}_${GENOME}" \
	--sample_name_parent2="${MOTHER_ID}_${GENOME}" \
  	--num_shards=$NSLOTS \
	--intermediate_results_dir="/output/intermediate_results_dir" \
	--output_gvcf_child="/output/$PROBAND_GVCF" \
	--output_gvcf_parent1="/output/$FATHER_GVCF" \
	--output_gvcf_parent2="/output/$MOTHER_GVCF" 
/mnt/common/Precision/GLNexus/glnexus_cli -c DeepVariant_unfiltered \
        $PROBAND_GVCF \
        $FATHER_GVCF \
        $MOTHER_GVCF \
        --threads $NSLOTS \
        > ${FAMILY_ID}.glnexus.merged.bcf
bcftools view ${FAMILY_ID}.glnexus.merged.bcf | bgzip -c > ${FAMILY_ID}.merged.vcf.gz
