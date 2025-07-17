#!/bin/bash
#FLUX: --job-name=gtex_decoupleR
#FLUX: --queue=largemem
#FLUX: -t=180000
#FLUX: --urgency=16

export SINGULARITYENV_PASSWORD='pass'
export SINGULARITYENV_USER='$USER'

module load R
module load Singularity/3.5.2-GCC-5.4.0-2.26
wd="$USER_DATA/230323_JW_DiseaseNetworks" #filepath to repo
src="$USER_DATA/230323_JW_DiseaseNetworks/src" #be sure that your subdirectories are structured the same
export SINGULARITYENV_PASSWORD='pass'
export SINGULARITYENV_USER='$USER'
cd ${wd}
SAMPLE_LIST="${wd}/results/array_inputs/GTEx_exp_files_array.txt" #note: make sure path and file name are correct
SAMPLE_ARRAY=(`cat ${SAMPLE_LIST}`) # parantheses instruct bash to create a shell array of strings from SAMPLE_LIST
GTEX_FILE=`echo ${SAMPLE_ARRAY[$SLURM_ARRAY_TASK_ID]}` #extracts a single input from the array and prints (using echo) it into INPUT variable, each single input is then assigned an array number by $SLURM_TASK_ID
PRIOR_NET="/data/project/lasseigne_lab/JordanWhitlock/230323_JW_DiseaseNetworks/data/human_prior_tri.csv"
echo "Prior Network from ${PRIOR_NET}"
MIN_N=5
singularity exec --cleanenv --containall \
  -B ${wd} \
  -B /data/project/lasseigne_lab/ \
  ${wd}/bin/PANDA_construction_docker/jw_diseasenetworks_1.0.0.sif \
  Rscript --vanilla ${wd}/src/tf_activity/02_decoupleR_analysis.R ${GTEX_FILE} ${PRIOR_NET} ${MIN_N} ${wd}
