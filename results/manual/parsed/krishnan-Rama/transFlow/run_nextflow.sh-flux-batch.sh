#!/bin/bash
#FLUX: --job-name=nf-deploy
#FLUX: --queue=<HPC queue>
#FLUX: --priority=16

module load singularity/3.8.7
module load nextflow/23.04.1
nextflow run main.nf -profile cluster -resume
