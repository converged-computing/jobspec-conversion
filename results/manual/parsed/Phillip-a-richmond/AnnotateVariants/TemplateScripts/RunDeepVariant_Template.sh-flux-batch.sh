#!/bin/bash
#FLUX: --job-name=milky-nunchucks-3269
#FLUX: -c=40
#FLUX: -t=259200
#FLUX: --urgency=16

export SINGULARITY_CACHEDIR='$PWD'

module load singularity
ANNOTATEVARIANTS_INSTALL=annotate_variants_dir
source $ANNOTATEVARIANTS_INSTALL/opt/miniconda3/etc/profile.d/conda.sh
conda activate $ANNOTATEVARIANTS_INSTALL/opt/AnnotateVariantsEnvironment
unset $PYTHONPATH
export SINGULARITY_CACHEDIR=$PWD
DeepVariant_SIF=deepvariant_sif
GLNexus_CLI=glnexus_cli
NSLOTS=$SLURM_CPUS_PER_TASK
cd $SLURM_SUBMIT_DIR
WORKING_DIR=working_dir
OUTPUT_DIR=$WORKING_DIR
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
SIBLING_ID=sibling_id
PED=$FAMILY_ID.ped
MOTHER_PRESENT=mother_boolean
FATHER_PRESENT=father_boolean
SIBLING_PRESENT=sibling_boolean
PROBAND_BAM=${PROBAND_ID}_${GENOME}.dupremoved.sorted.bam
FATHER_BAM=${FATHER_ID}_${GENOME}.dupremoved.sorted.bam
MOTHER_BAM=${MOTHER_ID}_${GENOME}.dupremoved.sorted.bam
SIBLING_BAM=${SIBLING_ID}_${GENOME}.dupremoved.sorted.bam
PROBAND_VCF=${PROBAND_ID}.vcf.gz
FATHER_VCF=${FATHER_ID}.vcf.gz
MOTHER_VCF=${MOTHER_ID}.vcf.gz
SIBLING_VCF=${SIBLING_ID}.vcf.gz
PROBAND_GVCF=${PROBAND_ID}.gvcf.gz
FATHER_GVCF=${FATHER_ID}.gvcf.gz
MOTHER_GVCF=${MOTHER_ID}.gvcf.gz
SIBLING_GVCF=${SIBLING_ID}.gvcf.gz
singularity exec -e -c -B /usr/lib/locale/:/usr/lib/locale/ \
	-B "${BAM_DIR}":"/bamdir" \
	-B "${FASTA_DIR}":"/genomedir" \
	-B "${OUTPUT_DIR}":"/output" \
	-W $OUTPUT_DIR \
	$DeepVariant_SIF \
  /opt/deepvariant/bin/run_deepvariant \
  --model_type=WGS \
  --ref="/genomedir/$FASTA_FILE" \
	  --intermediate_results_dir="/output/intermediate_results_dir" \
  --reads="/bamdir/$PROBAND_BAM" \
  --output_vcf="/output/$PROBAND_VCF" \
  --output_gvcf="/output/$PROBAND_GVCF" \
  --num_shards=$NSLOTS \
if [ "$SIBLING_PRESENT" = true ] ; then
	singularity exec -e -c -B /usr/lib/locale/:/usr/lib/locale/ \
		-B "${BAM_DIR}":"/bamdir" \
		-B "${FASTA_DIR}":"/genomedir" \
		-B "${OUTPUT_DIR}":"/output" \
		-W $OUTPUT_DIR \
		$DeepVariant_SIF \
	  /opt/deepvariant/bin/run_deepvariant \
	  --model_type=WGS \
	  --ref="/genomedir/$FASTA_FILE" \
	  --intermediate_results_dir="/output/intermediate_results_dir" \
	  --reads="/bamdir/$SIBLING_BAM" \
	  --output_vcf="/output/$SIBLING_VCF" \
	  --output_gvcf="/output/$SIBLING_GVCF" \
	  --num_shards=$NSLOTS 
fi
if [ "$MOTHER_PRESENT" = true ] ; then
	singularity exec -e -c -B /usr/lib/locale/:/usr/lib/locale/ \
		-B "${BAM_DIR}":"/bamdir" \
		-B "${FASTA_DIR}":"/genomedir" \
		-B "${OUTPUT_DIR}":"/output" \
		-W $OUTPUT_DIR \
		$DeepVariant_SIF \
	  /opt/deepvariant/bin/run_deepvariant \
	  --model_type=WGS \
	  --ref="/genomedir/$FASTA_FILE" \
	  --intermediate_results_dir="/output/intermediate_results_dir" \
	  --reads="/bamdir/$MOTHER_BAM" \
	  --output_vcf="/output/$MOTHER_VCF" \
	  --output_gvcf="/output/$MOTHER_GVCF" \
	  --num_shards=$NSLOTS 
fi
if [ "$FATHER_PRESENT" = true ] ; then
	singularity exec -e -c -B /usr/lib/locale/:/usr/lib/locale/ \
		-B "${BAM_DIR}":"/bamdir" \
		-B "${FASTA_DIR}":"/genomedir" \
		-B "${OUTPUT_DIR}":"/output" \
		-W $OUTPUT_DIR \
                $DeepVariant_SIF \
	  /opt/deepvariant/bin/run_deepvariant \
	  --model_type=WGS \
	  --intermediate_results_dir="/output/intermediate_results_dir" \
	  --ref="/genomedir/$FASTA_FILE" \
	  --reads="/bamdir/$FATHER_BAM" \
	  --output_vcf="/output/$FATHER_VCF" \
	  --output_gvcf="/output/$FATHER_GVCF" \
	  --num_shards=$NSLOTS 
fi
$GLNexus_CLI \
	-c DeepVariant_unfiltered \
        --threads $NSLOTS \
        *gvcf.gz \
        > ${FAMILY_ID}.glnexus.merged.bcf
bcftools view ${FAMILY_ID}.glnexus.merged.bcf | bgzip -c > ${FAMILY_ID}.merged.vcf.gz
