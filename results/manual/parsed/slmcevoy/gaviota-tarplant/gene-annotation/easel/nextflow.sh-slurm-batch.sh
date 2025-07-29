#!/bin/bash
#FLUX: --job-name=gvtp
#FLUX: -c=4
#FLUX: --queue=general
#FLUX: --urgency=16

module load nextflow
SINGULARITY_TMPDIR=$PWD/tmp
export SINGULARITY_TMPDIR
TMPDIR=$PWD/tmpdir
export TMPDIR
nextflow run -hub gitlab PlantGenomicsLab/easel-benchmarking-v2-nf -profile singularity,xanadu -params-file gvtp.yaml
