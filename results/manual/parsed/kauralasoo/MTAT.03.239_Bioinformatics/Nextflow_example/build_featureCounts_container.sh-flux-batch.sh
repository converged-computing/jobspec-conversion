#!/bin/bash
#FLUX: --job-name="nf-featureCounts"
#FLUX: --queue=testing
#FLUX: -t=7200
#FLUX: --priority=16

module load any/singularity/3.7.3
module load squashfs/4.4
singularity build featureCounts.img docker://quay.io/eqtlcatalogue/rnaseq:v20.11.1
