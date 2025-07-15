#!/bin/bash
#FLUX: --job-name=wobbly-spoon-2983
#FLUX: -c=4
#FLUX: --priority=16

export NXF_VER='20.04.1'

cd $SLURM_SUBMIT_DIR
date;hostname;pwd
module load singularity
export NXF_VER=20.04.1
curl -fsSL get.nextflow.io | bash
./nextflow run /projects/anczukow-lab/splicing_pipeline/splicing-pipelines-nf/main.nf \
	--outdir ${SLURM_SUBMIT_DIR} \
	-config NF_splicing_pipeline.config \
	-profile sumner -resume \
        -with-report report.html \
        -with-trace trace.txt \
        -with-timeline timeline.html \
        -with-dag DAG.png
