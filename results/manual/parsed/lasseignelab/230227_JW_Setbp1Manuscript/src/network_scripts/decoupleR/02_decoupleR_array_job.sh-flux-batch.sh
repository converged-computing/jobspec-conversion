#!/bin/bash
#FLUX: --job-name=kid_decoupleR
#FLUX: --queue=largemem
#FLUX: -t=180000
#FLUX: --urgency=16

export SINGULARITYENV_PASSWORD='pass'
export SINGULARITYENV_USER='jbarham3' #change this to your user'

module load R
module load Singularity/3.5.2-GCC-5.4.0-2.26
wd=/data/user/jbarham3/230227_JW_Setbp1Manuscript #change this to match your project directory path
export SINGULARITYENV_PASSWORD='pass'
export SINGULARITYENV_USER='jbarham3' #change this to your user
cd ${wd}
RDATA_FILE=${wd}/data/processed/decoupleR_expression_inputs/kidney_expression.Rdata
echo "Opening ${RDATA_FILE}"
PRIOR_NET=${wd}/data/processed/decoupleR_prior_CollecTRI/mouse_prior_tri.csv
echo "Prior Network from ${PRIOR_NET}"
ITEM=$(Rscript -e "load('${RDATA_FILE}'); cat(names(decoupleR_expression)[${SLURM_ARRAY_TASK_ID}])")
echo "Processing: ${ITEM}"
TISSUE="kidney"
MIN_N=5
singularity exec --cleanenv --no-home -B ${wd} ${wd}/bin/docker/setbp1_manuscript_1.0.6.sif Rscript --vanilla ${wd}/src/network_scripts/decoupleR/02_decoupleR_analysis.R ${RDATA_FILE} ${PRIOR_NET} ${ITEM} ${TISSUE} ${MIN_N}
