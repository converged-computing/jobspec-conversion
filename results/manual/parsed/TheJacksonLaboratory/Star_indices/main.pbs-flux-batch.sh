#!/bin/bash
#FLUX: --job-name=hairy-pancake-3208
#FLUX: -c=4
#FLUX: --priority=16

cd $SLURM_SUBMIT_DIR
date;hostname;pwd
module load singularity
curl -fsSL get.nextflow.io | bash
./nextflow run /projects/anczukow-lab/star_index_pipeline/Star_indices/main.nf \
	--outdir ${SLURM_SUBMIT_DIR} \
	-config NF_Star_Index.config \
	-profile sumner -resume \
        -with-report report.html \
        -with-timeline timeline.html 
