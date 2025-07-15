#!/bin/bash
#FLUX: --job-name=03_SNPj_filterdp_PROW_reducedref
#FLUX: --queue=comp01
#FLUX: -t=3600
#FLUX: --urgency=16

module load python/anaconda-3.9
source /share/apps/bin/conda-3.9.sh
conda activate BCFTools
cd /local_scratch/$SLURM_JOB_ID/
SPP=PROW 
PROJECT_DIR=/scrfs/storage/amatthews/20210816_projects/20210816_snp
REF_DIR=$PROJECT_DIR/02_IndexRef/ref_full
REF=scaffolds_reduced_contigs_kept
REFTYPE=ref_reduced
SNP_DIR=$PROJECT_DIR/03_SNP_20220513
RESULTS_DIR=$SNP_DIR/RESULTS_${REFTYPE}_$SPP
bcftools +setGT ${RESULTS_DIR}/vcf/${SPP}_ALL_renamed_q30_minac1_maf05.vcf.gz --output-type z --output ${RESULTS_DIR}/vcf/${SPP}_ALL_renamed_q30_minac1_maf05_dp05.vcf.gz -- --target-gt q --new-gt . --include 'FORMAT/DP<5' 
bcftools +setGT ${RESULTS_DIR}/vcf/${SPP}_ALL_renamed_q30_minac1_maf05.vcf.gz --output-type z --output ${RESULTS_DIR}/vcf/${SPP}_ALL_renamed_q30_minac1_maf05_dp10.vcf.gz -- --target-gt q --new-gt . --include 'FORMAT/DP<10' 
bcftools +setGT ${RESULTS_DIR}/vcf/${SPP}_ALL_renamed_q30_minac1_maf05.vcf.gz --output-type z --output ${RESULTS_DIR}/vcf/${SPP}_ALL_renamed_q30_minac1_maf05_dp15.vcf.gz -- --target-gt q --new-gt . --include 'FORMAT/DP<15' 
bcftools +setGT ${RESULTS_DIR}/vcf/${SPP}_ALL_renamed_q30_minac1_maf05.vcf.gz --output-type z --output ${RESULTS_DIR}/vcf/${SPP}_ALL_renamed_q30_minac1_maf05_dp20.vcf.gz -- --target-gt q --new-gt . --include 'FORMAT/DP<20' 
