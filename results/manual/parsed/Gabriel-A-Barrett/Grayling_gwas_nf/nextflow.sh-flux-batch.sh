#!/bin/bash
#FLUX: --job-name=nextflow
#FLUX: --queue=general
#FLUX: --urgency=16

module load nextflow/22.04.0
nextflow run main.nf -entry NF_GWAS -resume -with-singularity gwas-nf.sif
