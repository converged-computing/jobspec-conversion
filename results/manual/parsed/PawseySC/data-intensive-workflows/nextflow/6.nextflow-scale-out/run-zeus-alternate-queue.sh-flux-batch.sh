#!/bin/bash
#FLUX: --job-name=Nextflow-master-RNAseq
#FLUX: --queue=workq
#FLUX: -t=10800
#FLUX: --priority=16

module load singularity  # just in case image pull is needed
module load nextflow
nextflow run rnaseq.nf -profile zeus --reads "data2/*_{1,2}.fq"
