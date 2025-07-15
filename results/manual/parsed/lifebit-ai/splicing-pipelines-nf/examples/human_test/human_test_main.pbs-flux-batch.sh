#!/bin/bash
#FLUX: --job-name=blue-pastry-1866
#FLUX: -c=4
#FLUX: --priority=16

cd $SLURM_SUBMIT_DIR
date;hostname;pwd
module load singularity
curl -fsSL get.nextflow.io | bash
./nextflow run /projects/anczukow-lab/splicing_pipeline/splicing-pipelines-nf/main.nf \
	-config /projects/anczukow-lab/splicing_pipeline/splicing-pipelines-nf/conf/examples/human_test.config  \
	--outdir ${SLURM_SUBMIT_DIR} \
	-profile sumner -resume \
	-with-report human_test.html \
	-with-timeline human_test_timeline.html 
