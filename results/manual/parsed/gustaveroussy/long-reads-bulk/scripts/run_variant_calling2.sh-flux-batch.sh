#!/bin/bash
#FLUX: --job-name=chr20_variant_calling2
#FLUX: -n=10
#FLUX: --queue=shortq
#FLUX: --priority=16

WDIR="/mnt/beegfs/scratch/bioinfo_core/B23043_NADR_02"
SAMPLE_NAME="3700_R10"
REF="${WDIR}/script/Homo_sapiens-GCA_009914755.4-unmasked.fa"
BAM="${WDIR}/data_output/${SAMPLE_NAME}/sambamba/${SAMPLE_NAME}_T2T-CHM13.chr20.bam"
THREADS="10"
OUTPUT_DIR="${WDIR}/data_output/${SAMPLE_NAME}/PEPPER_Margin_DeepVariant/chr20/"
OUTPUT_PREFIX="${SAMPLE_NAME}_T2T-CHM13.chr20"
OUTPUT_VCF="${SAMPLE_NAME}_T2T-CHM13.chr20.vcf.gz"
mkdir -p "${OUTPUT_DIR}"
module load singularity
singularity exec --bind ${WDIR} /mnt/beegfs/userdata/n_rabearivelo/containers/pepper_deepvariant_r0.8.sif run_pepper_margin_deepvariant call_variant \
--bam "${BAM}" \
--fasta "${REF}" \
--output_dir "${OUTPUT_DIR}" \
--output_prefix "${OUTPUT_PREFIX}" \
--threads ${THREADS} \
--sample_name ${SAMPLE_NAME} \
--ont_r10_q20
