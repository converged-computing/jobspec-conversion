#!/bin/bash
#FLUX: --job-name=RiboPrint
#FLUX: -n=2
#FLUX: -c=2
#FLUX: -t=3600
#FLUX: --priority=16

export NXF_SINGULARITY_CACHEDIR='$PWD/.singularity'
export SINGULARITY_CACHEDIR='$PWD/.singularity'

module load singularity
module load nextflow
module load ucsc
module load bedtools
module load R
export NXF_SINGULARITY_CACHEDIR=$PWD/.singularity
export SINGULARITY_CACHEDIR=$PWD/.singularity
mkdir -p Results
ResumeArg=$1
nextflow run RiboFootPrint.nf --workdir $PWD  -c nextflow.config -params-file RiboFootPrint.parameters.yaml  ${ResumeArg} 
