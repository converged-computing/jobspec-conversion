#!/bin/bash
#FLUX: --job-name=kid_vis_hall
#FLUX: --queue=short
#FLUX: -t=43200
#FLUX: --urgency=16

export SINGULARITYENV_PASSWORD='pass'
export SINGULARITYENV_USER='jbarham3'

module load Singularity/3.5.2-GCC-5.4.0-2.26
wd="/data/user/jbarham3/230227_JW_Setbp1Manuscript"
src="/data/user/jbarham3/230227_JW_Setbp1Manuscript/src/module_scores" #be sure that your subdirectories are structured the same
export SINGULARITYENV_PASSWORD='pass'
export SINGULARITYENV_USER='jbarham3'
cd ${wd}
singularity exec --cleanenv --no-home -B ${wd} ${wd}/bin/docker/setbp1_manuscript_1.0.11.sif Rscript --vanilla ${src}/02_Setbp1_vision_kidney_hallmarks.R # here vanilla ensures only the script is run and environment is kept clean
