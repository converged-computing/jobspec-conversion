#!/bin/bash
#FLUX: --job-name=ldak
#FLUX: -c=8
#FLUX: -t=3600
#FLUX: --urgency=16

export SUMSTATS='$1'
export GENEFILE='annotSorted.csv'
export BFILE='/ess/p697/cluster/projects/moba_qc_imputation/resources/HRC/plink/hrc_chr${SLURM_ARRAY_TASK_ID}_EUR_qc'
export RESULT_OUT='out/${SUMSTATS}_chr${SLURM_ARRAY_TASK_ID}'
export MIXER_SIF='/ess/p697/data/durable/s3-api/github/norment/ofrei_repo/2023_03_27/mixer.sif'
export PYTHON='singularity exec --home $PWD:/home ${MIXER_SIF} python'
export SUMSTATS_FOLDER='/ess/p697/cluster/users/ofrei/2023_02_06_GSA_MiXeR_natgen_revisions/sumstats_v3p1'
export SUMSTATS_LDAK='sumstats/${SUMSTATS}.chr${SLURM_ARRAY_TASK_ID}.ldak_sumstats'

source /cluster/bin/jobsetup
test $SCRATCH && module load singularity/3.7.1 
export SUMSTATS=$1
export GENEFILE=annotSorted.csv
export BFILE=/ess/p697/cluster/projects/moba_qc_imputation/resources/HRC/plink/hrc_chr${SLURM_ARRAY_TASK_ID}_EUR_qc
export RESULT_OUT=out/${SUMSTATS}_chr${SLURM_ARRAY_TASK_ID}
export MIXER_SIF="/ess/p697/data/durable/s3-api/github/norment/ofrei_repo/2023_03_27/mixer.sif"
export PYTHON="singularity exec --home $PWD:/home ${MIXER_SIF} python"
export SUMSTATS_FOLDER=/ess/p697/cluster/users/ofrei/2023_02_06_GSA_MiXeR_natgen_revisions/sumstats_v3p1
export SUMSTATS_LDAK=sumstats/${SUMSTATS}.chr${SLURM_ARRAY_TASK_ID}.ldak_sumstats
zcat ${SUMSTATS_FOLDER}/${SUMSTATS}.chr${SLURM_ARRAY_TASK_ID}.sumstats.gz | sed --expression="1s/RSID/SNP/" | sed --expression="1s/POS/POSITION/" | sed --expression="1s/EffectAllele/A1/" | sed --expression="1s/OtherAllele/A2/" > ${SUMSTATS_LDAK}
$PYTHON make_extract_list.py ${SLURM_ARRAY_TASK_ID} ${SUMSTATS_LDAK}   #  -> ${SUMSTATS}.chr${SLURM_ARRAY_TASK_ID}.ldak_sumstats.overlapHRC.justrs
./ldak5.2.linux --cut-genes ${RESULT_OUT} --gene-buffer 10000 --bfile ${BFILE} --genefile ${GENEFILE} --by-chr YES --extract ${SUMSTATS_LDAK}.overlapHRC.justrs
./ldak5.2.linux --calc-genes-reml ${RESULT_OUT} --summary ${SUMSTATS_LDAK}  --bfile ${BFILE} --ignore-weights YES --allow-ambiguous YES --power -0.25 --gene-prune 0.5 --gene-permutations 10 --extract ${SUMSTATS_LDAK}.overlapHRC.justrs
./ldak5.2.linux --join-genes-reml ${RESULT_OUT}
