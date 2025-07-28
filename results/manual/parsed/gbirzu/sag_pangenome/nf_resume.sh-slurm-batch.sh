#!/bin/bash
#FLUX: --job-name=resume_nf
#FLUX: -c=4
#FLUX: -t=86400
#FLUX: --urgency=16

WORKFLOW=$1
PROFILE=$2
ml ncbi-blast+
nextflow run ${WORKFLOW} -profile ${PROFILE} -resume
