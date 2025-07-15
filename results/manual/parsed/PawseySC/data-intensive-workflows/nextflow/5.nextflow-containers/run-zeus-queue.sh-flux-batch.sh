#!/bin/bash
#FLUX: --job-name=Nextflow-master-BLAST
#FLUX: --queue=workq
#FLUX: -t=1800
#FLUX: --priority=16

module load singularity  # just in case image pull is needed
module load nextflow
nextflow run blast.nf -profile zeus
ls -ltr
