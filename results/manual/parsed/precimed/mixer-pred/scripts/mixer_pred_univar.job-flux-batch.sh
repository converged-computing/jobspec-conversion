#!/bin/bash
#FLUX: --job-name=plsa2d
#FLUX: -c=16
#FLUX: -t=172800
#FLUX: --urgency=16

export THREADS='16 	# note this is equal to the number of cpus used when batching above'
export APPTAINER_BIND=''
export SINGULARITY_BIND=''
export MIXER_SIF='/ess/p697/data/durable/s3-api/github/norment/ofrei_repo/2023_03_27/mixer.sif'
export MIXER_PY='singularity exec --home $PWD:/home --bind /ess/p697:/ess/p697 ${MIXER_SIF} python         /tools/mixer/precimed/mixer.py'
export MIXER_FIGURES_PY='singularity exec --home $PWD:/home --bind /ess/p697:/ess/p697 ${MIXER_SIF} python /tools/mixer/precimed/mixer_figures.py'
export ANALYSIS_ROOT='/cluster/projects/p697/users/nadinepa/MiXeR_Pred/FINAL_MiXeR_Pred'
export OUT_FOLDER='${ANALYSIS_ROOT}/MiXeR/out'
export SUMSTATS_FOLDER='${ANALYSIS_ROOT}/sumstats'
export SUMSTATS_FILE='$1'
export REFERENCE_FOLDER='/ess/p697/data/durable/s3-api/github/precimed/mixer_private_docker/reference'
export REP='${SLURM_ARRAY_TASK_ID}'
export LOADLIB_FILE='/ess/p697/cluster/projects/moba_qc_imputation/resources/HRC/plink/tsd_libfile_hrc_chr@.bin'
export COMMON_FLAGS='${COMMON_FLAGS} --use-complete-tag-indices --loadlib-file ${LOADLIB_FILE}'
export EXTRA_FLAGS_U='--exclude-ranges MHC --z1max 9.336'

source /cluster/bin/jobsetup
module load singularity/3.7.1
export THREADS=16 	# note this is equal to the number of cpus used when batching above
export APPTAINER_BIND=
export SINGULARITY_BIND=
export MIXER_SIF=/ess/p697/data/durable/s3-api/github/norment/ofrei_repo/2023_03_27/mixer.sif
md5sum ${MIXER_SIF}
export MIXER_PY="singularity exec --home $PWD:/home --bind /ess/p697:/ess/p697 ${MIXER_SIF} python         /tools/mixer/precimed/mixer.py"
export MIXER_FIGURES_PY="singularity exec --home $PWD:/home --bind /ess/p697:/ess/p697 ${MIXER_SIF} python /tools/mixer/precimed/mixer_figures.py"
export ANALYSIS_ROOT=/cluster/projects/p697/users/nadinepa/MiXeR_Pred/FINAL_MiXeR_Pred
export OUT_FOLDER=${ANALYSIS_ROOT}/MiXeR/out
export SUMSTATS_FOLDER=${ANALYSIS_ROOT}/sumstats
export SUMSTATS_FILE=$1
export REFERENCE_FOLDER=/ess/p697/data/durable/s3-api/github/precimed/mixer_private_docker/reference
export REP=${SLURM_ARRAY_TASK_ID}
export LOADLIB_FILE=/ess/p697/cluster/projects/moba_qc_imputation/resources/HRC/plink/tsd_libfile_hrc_chr@.bin
export COMMON_FLAGS="${COMMON_FLAGS} --bim-file ${REFERENCE_FOLDER}/hrc_EUR_qc/hrc_chr@_EUR_qc.bim"
export COMMON_FLAGS="${COMMON_FLAGS} --ld-file ${REFERENCE_FOLDER}/hrc_EUR_qc/hrc_chr@_EUR_qc.run1.ld"
export COMMON_FLAGS="${COMMON_FLAGS} --use-complete-tag-indices --loadlib-file ${LOADLIB_FILE}"
export EXTRA_FLAGS_U="--exclude-ranges MHC --z1max 9.336"
  # remember that for PLSA analysis sumstats should be split per chromosome, as follows
${MIXER_PY} split_sumstats --trait1-file ${SUMSTATS_FOLDER}/${SUMSTATS_FILE}.sumstats.gz --out ${SUMSTATS_FOLDER}/${SUMSTATS_FILE}.chr@.sumstats.gz
  echo -e '\n=== PLSA FIT0 ===========================================================================\n'
  ${MIXER_PY} plsa --gsa-base ${COMMON_FLAGS} \
          --trait1-file ${SUMSTATS_FOLDER}/${SUMSTATS_FILE}.chr@.sumstats.gz \
          --out ${OUT_FOLDER}/${SUMSTATS_FILE}_rep${REP}.fit0 \
          --extract ${REFERENCE_FOLDER}/hrc_EUR_qc/hrc_EUR_qc.prune_rand2M_rep${REP}.snps --hardprune-r2 0.8 \
          --go-file ${REFERENCE_FOLDER}/gsa-mixer-baseline-annot_27jan2022.csv \
          --annot-file ${REFERENCE_FOLDER}/hrc_EUR_qc/baseline_v2.2_hrc_chr@_EUR_qc.annot.gz \
          --annot-file-test ${REFERENCE_FOLDER}/hrc_EUR_qc/baseline_v2.2_hrc_chr@_EUR_qc.annot.gz \
          --seed $((REP+1000)) --threads ${THREADS} ${EXTRA_FLAGS_U}
  echo -e '\n==== PLSA FIT1 ==========================================================================\n'
  ${MIXER_PY} fit1 ${COMMON_FLAGS} \
          --trait1-file ${SUMSTATS_FOLDER}/${SUMSTATS_FILE}.sumstats.gz \
          --out ${OUT_FOLDER}/${SUMSTATS_FILE}_rep${REP}.fit1 \
          --load-params-file ${OUT_FOLDER}/${SUMSTATS_FILE}_rep${REP}.fit0.json \
          --go-file ${REFERENCE_FOLDER}/gsa-mixer-baseline-annot_27jan2022.csv \
          --annot-file ${REFERENCE_FOLDER}/hrc_EUR_qc/baseline_v2.2_hrc_chr@_EUR_qc.annot.gz \
          --extract ${REFERENCE_FOLDER}/hrc_EUR_qc/hrc_EUR_qc.prune_rand2M_rep${REP}.snps --hardprune-r2 0.8 \
          --seed $((REP+1000)) --threads ${THREADS} ${EXTRA_FLAGS_U} 
  echo -e '\n==== PLSA TEST1 ==========================================================================\n'
  ${MIXER_PY} test1 ${COMMON_FLAGS} \
          --trait1-file ${SUMSTATS_FOLDER}/${SUMSTATS_FILE}.sumstats.gz \
          --out ${OUT_FOLDER}/${SUMSTATS_FILE}_rep${REP}.test1 \
          --load-params-file ${OUT_FOLDER}/${SUMSTATS_FILE}_rep${REP}.fit1.json \
          --go-file ${REFERENCE_FOLDER}/gsa-mixer-baseline-annot_27jan2022.csv \
          --annot-file ${REFERENCE_FOLDER}/hrc_EUR_qc/baseline_v2.2_hrc_chr@_EUR_qc.annot.gz \
          --make-snps-file \
          --seed $((REP+1000)) --threads ${THREADS} ${EXTRA_FLAGS_U}  
