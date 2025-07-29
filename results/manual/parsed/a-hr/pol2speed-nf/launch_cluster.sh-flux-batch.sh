#!/bin/bash
#FLUX --job-name=nerdy-fork-5674
#FLUX -t=72000
#FLUX --urgency=16

export NXF_OPTS='-Xms500M -Xmx8G'

module load Singularity Nextflow Go
export NXF_OPTS="-Xms500M -Xmx8G"
nextflow run main.nf -resume -profile cluster -params-file input_params.yaml
