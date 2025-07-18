#!/bin/bash
#FLUX: --job-name=bivar
#FLUX: -c=16
#FLUX: -t=172800
#FLUX: --urgency=16

export THREADS='16 '
export ANALYSIS_ROOT='/cluster/projects/p697/users/nadinepa/MiXeR_Pred'
export OUT_FOLDER='${ANALYSIS_ROOT}/MiXeR/out'
export SUMSTATS_FOLDER='${ANALYSIS_ROOT}/sumstats'
export MIXER_SIF='/ess/p697/data/durable/s3-api/github/norment/ofrei_repo/2023_03_27/mixer.sif'
export MIXER_FIGURES_PY='singularity exec --home $PWD:/home --bind /ess/p697:/ess/p697 ${MIXER_SIF} python /tools/mixer/precimed/mixer_figures.py'
export REFERENCE_FOLDER='/ess/p697/data/durable/s3-api/github/precimed/mixer_private_docker/reference'
export APPTAINER_BIND=''
export SINGULARITY_BIND=''
export REP='${SLURM_ARRAY_TASK_ID}'
export LOADLIB_FILE='/ess/p697/cluster/projects/moba_qc_imputation/resources/HRC/plink/tsd_libfile_hrc_chr@.bin'
export SUMSTATS_FILE='$1'
export SUMSTATS2_FILE='$2'
export COMMON_FLAGS='${COMMON_FLAGS} --use-complete-tag-indices --loadlib-file ${LOADLIB_FILE}'
export EXTRA_FLAGS_B='--exclude-ranges MHC --z1max 9.336 --z2max 9.336'

source /cluster/bin/jobsetup
export THREADS=16 
export ANALYSIS_ROOT=/cluster/projects/p697/users/nadinepa/MiXeR_Pred
export OUT_FOLDER=${ANALYSIS_ROOT}/MiXeR/out
export SUMSTATS_FOLDER=${ANALYSIS_ROOT}/sumstats
module load singularity/3.7.1 
export MIXER_SIF=/ess/p697/data/durable/s3-api/github/norment/ofrei_repo/2023_03_27/mixer.sif
export MIXER_FIGURES_PY="singularity exec --home $PWD:/home --bind /ess/p697:/ess/p697 ${MIXER_SIF} python /tools/mixer/precimed/mixer_figures.py"
export REFERENCE_FOLDER=/ess/p697/data/durable/s3-api/github/precimed/mixer_private_docker/reference
export APPTAINER_BIND=
export SINGULARITY_BIND=
export REP=${SLURM_ARRAY_TASK_ID}
export LOADLIB_FILE=/ess/p697/cluster/projects/moba_qc_imputation/resources/HRC/plink/tsd_libfile_hrc_chr@.bin
export SUMSTATS_FILE=$1
export SUMSTATS2_FILE=$2
export COMMON_FLAGS="${COMMON_FLAGS} --bim-file ${REFERENCE_FOLDER}/hrc_EUR_qc/hrc_chr@_EUR_qc.bim"
export COMMON_FLAGS="${COMMON_FLAGS} --ld-file ${REFERENCE_FOLDER}/hrc_EUR_qc/hrc_chr@_EUR_qc.run1.ld"
export COMMON_FLAGS="${COMMON_FLAGS} --use-complete-tag-indices --loadlib-file ${LOADLIB_FILE}"
export EXTRA_FLAGS_B="--exclude-ranges MHC --z1max 9.336 --z2max 9.336"
  echo -e '\n==== PLSA FIT2 ==========================================================================\n'
  ${MIXER_PY} fit2 ${COMMON_FLAGS} \
          --trait1-file ${SUMSTATS_FOLDER}/${SUMSTATS_FILE}.sumstats.gz \
          --trait2-file ${SUMSTATS_FOLDER}/${SUMSTATS2_FILE}.sumstats.gz \
          --trait1-params-file ${OUT_FOLDER}/${SUMSTATS_FILE}_rep${REP}.fit1.json \
          --trait2-params-file ${OUT_FOLDER}/${SUMSTATS2_FILE}_rep${REP}.fit1.json \
          --go-file ${REFERENCE_FOLDER}/gsa-mixer-baseline-annot_27jan2022.csv \
          --annot-file ${REFERENCE_FOLDER}/hrc_EUR_qc/baseline_v2.2_hrc_chr@_EUR_qc.annot.gz \
          --make-snps-file \
          --out ${OUT_FOLDER}/${SUMSTATS_FILE}_vs_${SUMSTATS2_FILE}_rep${REP}.fit2 \
          --extract ${REFERENCE_FOLDER}/hrc_EUR_qc/hrc_EUR_qc.prune_rand2M_rep${REP}.snps --hardprune-r2 0.8 \
          --seed $((REP+1000)) --threads ${THREADS} ${EXTRA_FLAGS_B}
  echo -e '\n==== PLSA TEST2 ==========================================================================\n'
  ${MIXER_PY} test2 ${COMMON_FLAGS} \
          --trait1-file ${SUMSTATS_FOLDER}/${SUMSTATS_FILE}.sumstats.gz \
          --trait2-file ${SUMSTATS_FOLDER}/${SUMSTATS2_FILE}.sumstats.gz \
          --load-params-file ${OUT_FOLDER}/${SUMSTATS_FILE}_vs_${SUMSTATS2_FILE}_rep${REP}.fit2.json \
          --go-file ${REFERENCE_FOLDER}/gsa-mixer-baseline-annot_27jan2022.csv \
          --annot-file ${REFERENCE_FOLDER}/hrc_EUR_qc/baseline_v2.2_hrc_chr@_EUR_qc.annot.gz \
          --make-snps-file \
          --out ${OUT_FOLDER}/${SUMSTATS_FILE}_vs_${SUMSTATS2_FILE}_rep${REP}.test2 \
          --seed $((REP+1000)) --threads ${THREADS} ${EXTRA_FLAGS_B} 
