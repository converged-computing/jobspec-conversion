#!/bin/bash
#FLUX: --job-name=PANDA
#FLUX: --queue=largemem
#FLUX: -t=43200
#FLUX: --priority=16

module load Singularity/3.5.2-GCC-5.4.0-2.26
wd="${USER_DATA}/projects/230418_TS_AgingCCC/"
cd ${wd}
SAMPLE_LIST="${wd}/data/PANDA_inputs/PANDA_exp_files_array.txt" 
SAMPLE_ARRAY=(`cat ${SAMPLE_LIST}`) 
INPUT=`echo ${SAMPLE_ARRAY[$SLURM_ARRAY_TASK_ID]}`
singularity exec --cleanenv --containall -B ${wd} ${wd}/bin/docker/setbp1_manuscript_panda_1.0.1_latest.sif \
Rscript --vanilla ${wd}/src/gene_targeting/02_PANDA.R \
${INPUT} ${wd}
