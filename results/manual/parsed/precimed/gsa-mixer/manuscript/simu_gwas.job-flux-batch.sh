#!/bin/bash
#FLUX: --job-name=simugwa5
#FLUX: -c=16
#FLUX: -t=43200
#FLUX: --urgency=16

export THREADS='16'
export FOLDER='/ess/p697/cluster/users/ofrei/2023_02_06_GSA_MiXeR_natgen_revisions/simu_snps'
export TASKLIST='/ess/p697/cluster/users/ofrei/gsa_mixer_analysis/task_list_run10a.txt'
export FNAME='$(sed "${SLURM_ARRAY_TASK_ID}q;d" ${TASKLIST})'
export HSQ='$1'
export TMP_GWAS_OUT='${SCRATCH}/${FNAME}_hsq=${HSQ}'
export FNAME_GWAS_PREFIX='${FOLDER}/gwas_run14/${FNAME}'
export FNAME_GSA_BASE_OUT='${FOLDER}/base_run14/${FNAME}_hsq=${HSQ}'
export FNAME_GSA_FULL_OUT='${FOLDER}/full_run14/${FNAME}_hsq=${HSQ}'
export FNAME_GSA_HESS_OUT='${FOLDER}/hess_run14/${FNAME}_hsq=${HSQ}'
export FNAME_MAGMA_OUT='${FOLDER}/magma_run11_null/${FNAME}_hsq=${HSQ}'
export FNAME_GWAS_OUT='${FNAME_GWAS_PREFIX}_hsq=${HSQ}" '
export SUMSTATS_FILE='${FNAME_GWAS_OUT}.chr@.sumstats.gz'
export SUMSTATS_MAGMA_FILE='${FNAME_GWAS_OUT}.chr@.sumstats'
export SEED='123'
export CAUSAL_VARIANTS_FOLDER='${FOLDER}/causal_variants3'
export CAUSALS_BETA='${CAUSAL_VARIANTS_FOLDER}/${FNAME}.causals_beta.csv'
export GO_TEST_FILE='${CAUSAL_VARIANTS_FOLDER}/${FNAME}.genes.csv'
export MAGMA_SET_ANNOT='${CAUSAL_VARIANTS_FOLDER}/${FNAME}.magma.csv'
export MIXER_SIF='/ess/p697/data/durable/s3-api/github/norment/ofrei_repo/2023_03_27/mixer.sif'
export SIMU_LINUX='singularity exec --home $PWD:/home ${MIXER_SIF} simu_linux'
export PLINK2='singularity exec --home $PWD:/home ${MIXER_SIF} plink2'
export PYTHON='singularity exec --home $PWD:/home ${MIXER_SIF} python'
export MAGMA='singularity exec --home $PWD:/home --bind /ess/p697:/ess/p697 ${MIXER_SIF} magma'
export MIXER_PY='singularity exec --home $PWD:/home ${MIXER_SIF} python /ess/p697/cluster/users/ofrei/2023_02_06_GSA_MiXeR_natgen_revisions/precimed/mixer.py'
export BFILE='/ess/p697/cluster/users/ofrei/ukbdata/projects/plsa_mixer/ukb_genetics_qc/ukb_bed/ukb_imp_chr@_v3_qc'
export PLINK_EXTRACT='/cluster/projects/p697/users/ofrei/2023_02_06_GSA_MiXeR_natgen_revisions/simu_snps/base_maf=0.05_LDr2=0.90.snps'
export REFERENCE_FOLDER='/ess/p697/data/durable/s3-api/github/precimed/mixer_private_docker/reference'
export ANNOT_VERSION='annot_10mar2023'
export EXTRA_FLAGS=' --seed 1001  --exclude-ranges MHC'
export EXTRA_JUNK=''
export COMMON_ARGS='${COMMON_ARGS} --annot-file ${ANNOT_FILE} --annot-file-test ${ANNOT_FILE} '
export ANNOT_FILE='${REFERENCE_FOLDER}/ukb_EUR_qc/MAFbins_ukb_imp_chr@_v3_qc.annot.gz'
export MAGMA_BFILE='/ess/p697/cluster/users/ofrei/ukbdata/projects/plsa_mixer/ukb_genetics_qc/ukb_bed/ukb_imp_chr@_v3_qc_keep1k'
export MAGMA_GENE_LOC='${REFERENCE_FOLDER}/magma-gene-${ANNOT_VERSION}.csv'

export THREADS=16
source /cluster/bin/jobsetup
test $SCRATCH && module load singularity/3.7.1 
export FOLDER="/ess/p697/cluster/users/ofrei/2023_02_06_GSA_MiXeR_natgen_revisions/simu_snps"
export TASKLIST="/ess/p697/cluster/users/ofrei/gsa_mixer_analysis/task_list_run10a.txt"
export FNAME=$(sed "${SLURM_ARRAY_TASK_ID}q;d" ${TASKLIST})
echo "processing line ${SLURM_ARRAY_TASK_ID}: ${FNAME}... "
export HSQ=$1
echo "HSQ=${HSQ}"
export TMP_GWAS_OUT="${SCRATCH}/${FNAME}_hsq=${HSQ}"
export FNAME_GWAS_PREFIX="${FOLDER}/gwas_run14/${FNAME}"
export FNAME_GSA_BASE_OUT="${FOLDER}/base_run14/${FNAME}_hsq=${HSQ}"
export FNAME_GSA_FULL_OUT="${FOLDER}/full_run14/${FNAME}_hsq=${HSQ}"
export FNAME_GSA_HESS_OUT="${FOLDER}/hess_run14/${FNAME}_hsq=${HSQ}"
export FNAME_MAGMA_OUT="${FOLDER}/magma_run11_null/${FNAME}_hsq=${HSQ}"
export FNAME_GWAS_OUT="${FNAME_GWAS_PREFIX}_hsq=${HSQ}" 
export SUMSTATS_FILE=${FNAME_GWAS_OUT}.chr@.sumstats.gz
export SUMSTATS_MAGMA_FILE=${FNAME_GWAS_OUT}.chr@.sumstats
export SEED=123
export CAUSAL_VARIANTS_FOLDER=${FOLDER}/causal_variants3
export CAUSALS_BETA="${CAUSAL_VARIANTS_FOLDER}/${FNAME}.causals_beta.csv"
export GO_TEST_FILE="${CAUSAL_VARIANTS_FOLDER}/${FNAME}.genes.csv"
export MAGMA_SET_ANNOT="${CAUSAL_VARIANTS_FOLDER}/${FNAME}.magma.csv"
export MIXER_SIF="/ess/p697/data/durable/s3-api/github/norment/ofrei_repo/2023_03_27/mixer.sif"
export SIMU_LINUX="singularity exec --home $PWD:/home ${MIXER_SIF} simu_linux"
export PLINK2="singularity exec --home $PWD:/home ${MIXER_SIF} plink2"
export PYTHON="singularity exec --home $PWD:/home ${MIXER_SIF} python"
export MAGMA="singularity exec --home $PWD:/home --bind /ess/p697:/ess/p697 ${MIXER_SIF} magma"
export MIXER_PY="singularity exec --home $PWD:/home ${MIXER_SIF} python /ess/p697/cluster/users/ofrei/2023_02_06_GSA_MiXeR_natgen_revisions/precimed/mixer.py"
if [ ! -f "${FNAME_GWAS_PREFIX}_hsq=0.1.pheno" ]; then
export BFILE="/ess/p697/cluster/users/ofrei/ukbdata/projects/plsa_mixer/ukb_genetics_qc/ukb_bed/ukb_imp_chr@_v3_qc"
${SIMU_LINUX} --seed $SEED --bfile-chr $BFILE --qt --causal-variants ${CAUSALS_BETA} --hsq ${HSQ} --out ${FNAME_GWAS_OUT}
else
  echo "PHENO output already exists, skip (${FNAME_GWAS_PREFIX}_hsq=XXX.pheno)"
fi
if [ ! -f "${SUMSTATS_MAGMA_FILE}" ]; then
export PLINK_EXTRACT="/cluster/projects/p697/users/ofrei/2023_02_06_GSA_MiXeR_natgen_revisions/simu_snps/base_maf=0.05_LDr2=0.90.snps"
{ awk '{print $1}' ${CAUSALS_BETA}; cat ${PLINK_EXTRACT}; } | sort | uniq > ${TMP_GWAS_OUT}.gwas.snps
for chri in {1..22};
do
  export BFILE="/ess/p697/cluster/users/ofrei/ukbdata/projects/plsa_mixer/ukb_genetics_qc/ukb_bed/ukb_imp_chr${chri}_v3_qc"
  ${PLINK2} --glm allow-no-covars --extract ${TMP_GWAS_OUT}.gwas.snps --bfile $BFILE --pheno ${FNAME_GWAS_OUT}.pheno  --pheno-name trait1 --out ${TMP_GWAS_OUT}.chr${chri}
done 
$PYTHON concat_plink_and_convert.py ${TMP_GWAS_OUT}.chr@.trait1.glm.linear ${FNAME_GWAS_OUT}.chr@
for chri in {1..22};
do
  echo "purge temp files for chr${chri}"
  rm ${TMP_GWAS_OUT}.chr${chri}.trait1.glm.linear
  rm ${TMP_GWAS_OUT}.chr${chri}.log
done 
rm ${TMP_GWAS_OUT}.gwas.snps
else
  echo "GWAS output already exists, skip (${SUMSTATS_MAGMA_FILE})"
fi  # perform GWAS
export REFERENCE_FOLDER=/ess/p697/data/durable/s3-api/github/precimed/mixer_private_docker/reference
export ANNOT_VERSION=annot_10mar2023
export EXTRA_FLAGS=" --seed 1001  --exclude-ranges MHC"
export EXTRA_JUNK=
export COMMON_ARGS=""
export COMMON_ARGS="${COMMON_ARGS} --bim-file ${REFERENCE_FOLDER}/ukb_EUR_qc/ukb_imp_chr@_v3_qc.bim "
export COMMON_ARGS="${COMMON_ARGS} --ld-file ${REFERENCE_FOLDER}/ukb_EUR_qc/ukb_imp_chr@_v3_qc.run1.ld "
export COMMON_ARGS="${COMMON_ARGS} --use-complete-tag-indices --loadlib-file /ess/p697/cluster/users/ofrei/ukbdata/projects/plsa_mixer/lib_bin_randprune64/plsa_ukb_libbgmg_state_full_chr@.bin "
export ANNOT_FILE="${REFERENCE_FOLDER}/ukb_EUR_qc/MAFbins_ukb_imp_chr@_v3_qc.annot.gz"
export COMMON_ARGS="${COMMON_ARGS} --annot-file ${ANNOT_FILE} --annot-file-test ${ANNOT_FILE} "
if [ ! -f "${FNAME_GSA_BASE_OUT}_baseline.json" ]; then
${MIXER_PY} plsa --fit sig2-zeroA annot gene --l-value 0 --s-value 0  --h2-init-calibration 0.1 \
        --trait1-file ${SUMSTATS_FILE} \
        --out ${FNAME_GSA_BASE_OUT}_baseline \
        --go-file ${REFERENCE_FOLDER}/gsa-mixer-baseline-${ANNOT_VERSION}.csv \
        --go-file-test ${GO_TEST_FILE} \
        --threads ${THREADS} ${EXTRA_FLAGS} ${EXTRA_JUNK} ${COMMON_ARGS} \
        --se-samples 0
else
  echo "GSA BASE output already exists, skip (${FNAME_GSA_BASE_OUT}_baseline.json)"
fi
if [ ! -f "${FNAME_GSA_FULL_OUT}_model.json" ]; then
${MIXER_PY} plsa --fit gene --constrain-base-gene-category --nullify-go-all-genes-sig2-gene --adam-separate-by-chromosome --adam-beta1 0.1 --adam-beta2 0.8 \
        --trait1-file ${SUMSTATS_FILE} \
        --out ${FNAME_GSA_FULL_OUT}_model \
        --go-file ${REFERENCE_FOLDER}/gsa-mixer-gene-${ANNOT_VERSION}.csv \
        --go-file-test ${GO_TEST_FILE} \
        --load-params-file ${FNAME_GSA_BASE_OUT}_baseline.json \
        --threads ${THREADS} ${EXTRA_FLAGS} ${EXTRA_JUNK} ${COMMON_ARGS} \
else
  echo "GSA FULL output already exists, skip (${FNAME_GSA_FULL_OUT}_model.json)"
fi  # fit GSA MiXeR model
if [ ! -f "${FNAME_GSA_HESS_OUT}_model.go_test_enrich.csv" ]; then
${MIXER_PY} plsa --fit gene --constrain-base-gene-category --nullify-go-all-genes-sig2-gene --adam-separate-by-chromosome --adam-beta1 0.1 --adam-beta2 0.8 \
        --trait1-file ${SUMSTATS_FILE} \
        --out ${FNAME_GSA_HESS_OUT}_model \
        --go-file ${REFERENCE_FOLDER}/gsa-mixer-gene-${ANNOT_VERSION}.csv \
        --go-file-test ${GO_TEST_FILE} \
        --load-params-file ${FNAME_GSA_FULL_OUT}_model.json \
        --load-baseline-params-file ${FNAME_GSA_BASE_OUT}_baseline.json \
        --threads ${THREADS} ${EXTRA_FLAGS} ${EXTRA_JUNK} ${COMMON_ARGS} \
        --adam-disable --weights-file none --hardprune-r2 0.6 \
else
  echo "GSA HESS output already exists, skip (${FNAME_GSA_HESS_OUT}_model.go_test_enrich.csv)"
fi  # fit GSA MiXeR model
export MAGMA_BFILE=/ess/p697/cluster/users/ofrei/ukbdata/projects/plsa_mixer/ukb_genetics_qc/ukb_bed/ukb_imp_chr@_v3_qc_keep1k
export MAGMA_GENE_LOC=${REFERENCE_FOLDER}/magma-gene-${ANNOT_VERSION}.csv
if [ ! -f "${FNAME_MAGMA_OUT}.magma.gsa.out" ]; then
$MAGMA --snp-loc ${MAGMA_BFILE}.bim \
       --gene-loc ${MAGMA_GENE_LOC} \
       --out ${FNAME_MAGMA_OUT}.magma.step1 \
       --annotate window=10 
$MAGMA --pval ${SUMSTATS_MAGMA_FILE} snp-id=SNP pval=PVAL ncol=N \
       --bfile ${MAGMA_BFILE} \
       --gene-annot ${FNAME_MAGMA_OUT}.magma.step1.genes.annot \
       --out ${FNAME_MAGMA_OUT}.magma.step2
$MAGMA --gene-results ${FNAME_MAGMA_OUT}.magma.step2.genes.raw \
       --set-annot ${MAGMA_SET_ANNOT} \
       --out ${FNAME_MAGMA_OUT}.magma
else
       echo "MAGMA output already exists, skip (${FNAME_MAGMA_OUT}.magma.gsa.out)"
fi # MAGMA
