#!/bin/bash
#FLUX: --job-name=nf-featureCounts
#FLUX: --queue=testing
#FLUX: -t=7200
#FLUX: --urgency=16

module load any/singularity/3.7.3
module load squashfs/4.4
singularity build hisat2.img docker://quay.io/eqtlcatalogue/rnaseq_hisat2:v22.03.01
