#!/bin/bash
#FLUX: --job-name=boopy-dog-2715
#FLUX: --queue=batch
#FLUX: -t=864000
#FLUX: --urgency=16

module load java/18.0.2.1
module load nextflow/22.10.5
nextflow run /labs/asbhatt/wirbel/AWIgen2/AWIGen2Microbiome/workflows/assembly.nf \
	-c /labs/asbhatt/wirbel/AWIgen2/AWIGen2Microbiome/workflows/config/run_assembly.config \
	-params-file /labs/asbhatt/wirbel/AWIgen2/AWIGen2Microbiome/workflows/config/params.yml \
	--input /labs/asbhatt/data/bhatt_lab_sequencing/23-03-08_awigen2/stats/preprocessed_reads.csv \
	-with-trace -with-report
