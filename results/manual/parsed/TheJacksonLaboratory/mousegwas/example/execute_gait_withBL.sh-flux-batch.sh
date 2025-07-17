#!/bin/bash
#FLUX: --job-name=fuzzy-general-7446
#FLUX: --queue=compute
#FLUX: -t=87300
#FLUX: --urgency=16

export G='https://raw.githubusercontent.com/TheJacksonLaboratory/mousegwas'

module load singularity
export G=https://raw.githubusercontent.com/TheJacksonLaboratory/mousegwas
nextflow run TheJacksonLaboratory/mousegwas -profile jax --yaml $G/example/gait_nowild_withBL.yaml --shufyaml $G/example/gait_shuffle_withBL.yaml --input $G/example/gait_paper_strain_survey_2019_11_12.csv --outdir gait_output_noBL --clusters 1 --addpostp "--colorgroup --meanvariance --set3 --minherit 0.25 --loddrop 1.5" --addheatmap "--meanvariance -p 0.1"  -resume
