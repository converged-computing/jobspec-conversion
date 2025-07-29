#!/bin/bash
#FLUX: --job-name=Nextflow-master-RNAseq
#FLUX: --queue=workq
#FLUX: -t=1800
#FLUX: --urgency=16

module load singularity  # just in case image pull is needed
module load nextflow
nextflow run rnaseq.nf -profile zeus
