#!/bin/bash
#FLUX: --job-name=hanky-peanut-butter-2839
#FLUX: -c=4
#FLUX: --queue=batch
#FLUX: -t=86400
#FLUX: --urgency=16

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
