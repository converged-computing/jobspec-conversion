#!/bin/bash
#FLUX: --job-name=bumfuzzled-cupcake-7486
#FLUX: -c=4
#FLUX: --priority=16

cd $SLURM_SUBMIT_DIR
date;hostname;pwd
module load singularity
curl -fsSL get.nextflow.io | bash
./nextflow run /projects/anczukow-lab/splicing_pipeline/splicing-pipelines-nf/main.nf \
	--outdir ${SLURM_SUBMIT_DIR} \
	-config NF_splicing_pipeline.config \
	-profile sumner -resume \
        -with-report report.html \
        -with-trace trace.txt \
        -with-timeline timeline.html \
        -with-dag DAG.png
