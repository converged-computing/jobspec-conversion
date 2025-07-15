#!/bin/bash
#FLUX: --job-name=spicy-house-8052
#FLUX: -c=4
#FLUX: -t=180000
#FLUX: --urgency=16

export SNPTEST='/scratch/mrc-epid/bin/snptest_v2.5.2_linux_x86_64_dynamic/snptest_v2.5.2'
export DIR='/scratch/mrc-epid/genetics/metabolomics/metabolon_gwas/SNPTEST'

. /etc/profile.d/modules.sh                # Leave this line (enables the module command)
module purge                               # Removes all modules still loaded
module load default-impi                   # REQUIRED - loads the basic environment
export SNPTEST=/scratch/mrc-epid/bin/snptest_v2.5.2_linux_x86_64_dynamic/snptest_v2.5.2
export DIR=/scratch/mrc-epid/genetics/metabolomics/metabolon_gwas/SNPTEST
TRAIT="$(cat $DIR/metabolitelist_SNPTEST_priority.txt | awk '{print $1}' | head -n ${SLURM_ARRAY_TASK_ID} | tail -n 1 )"
for i in {1..22}
do
$SNPTEST \
-data $DIR/../data/UK10K-HRC-EPIC.chr${i}_met5841.gen.gz $DIR/../data/UK10K-HRC-EPIC.chr${i}_met5841_SNPTESTformat_PCx100.sample \
-method expected \
-frequentist 1 \
-pheno $TRAIT \
-cov_names EPICN_OMICS_PC1x100 EPICN_OMICS_PC2x100 EPICN_OMICS_PC3x100 EPICN_OMICS_PC4x100 \
-missing_code -9 \
-use_raw_phenotypes \
-use_raw_covariates \
-exclude_samples $DIR/../data/related_exclusions_IDs.txt \
-o $DIR/results/${TRAIT}/EPICNorfolk_SNPTEST_${TRAIT}_HRC1KGUK10K_chr${i} > $DIR/output/EPICNorfolk_SNPTEST_${TRAIT}_HRC1KGUK10K_chr${i}.log
gzip $DIR/results/${TRAIT}/EPICNorfolk_SNPTEST_${TRAIT}_HRC1KGUK10K_chr${i}
done
