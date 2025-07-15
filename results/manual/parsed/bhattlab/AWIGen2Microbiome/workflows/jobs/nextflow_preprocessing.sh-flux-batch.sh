#!/bin/bash
#FLUX: --job-name=dirty-cherry-5689
#FLUX: --queue=batch
#FLUX: -t=864000
#FLUX: --priority=16

module load java/18.0.2.1
module load nextflow/22.10.5
nextflow run /labs/asbhatt/wirbel/AWIgen2/AWIGen2Microbiome/workflows/preprocessing.nf \
	-c /labs/asbhatt/wirbel/AWIgen2/AWIGen2Microbiome/workflows/config/run_preprocessing.config \
	-params-file /labs/asbhatt/wirbel/AWIgen2/AWIGen2Microbiome/workflows/config/params.yml \
	-with-trace -with-report -resume
