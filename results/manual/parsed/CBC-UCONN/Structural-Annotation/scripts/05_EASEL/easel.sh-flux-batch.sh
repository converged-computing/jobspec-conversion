#!/bin/bash
#FLUX: --job-name=EASEL
#FLUX: --queue=general
#FLUX: --priority=16

module load nextflow
SINGULARITY_TMPDIR=$PWD
export SINGULARITY_TMPDIR
nextflow run -hub gitlab PlantGenomicsLab/easel -profile singularity,xanadu -params-file params.yaml 
