#!/bin/bash
#FLUX: --job-name=phat-cherry-0162
#FLUX: --queue=batch
#FLUX: -t=864000
#FLUX: --urgency=16

module load java/18.0.2.1
module load nextflow/22.10.5
nextflow run /labs/asbhatt/wirbel/AWIgen2/AWIGen2Microbiome/workflows/classification.nf \
	-c /labs/asbhatt/wirbel/AWIgen2/AWIGen2Microbiome/workflows/config/run_classification.config \
	-params-file /labs/asbhatt/wirbel/SCRATCH/params_awigen1.yml \
	--input /labs/asbhatt/wirbel/AWIgen2/awigen1/stats/preprocessed_reads.csv \
	-with-trace -with-report
