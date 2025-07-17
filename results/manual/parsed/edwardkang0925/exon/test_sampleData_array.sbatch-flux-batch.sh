#!/bin/bash
#FLUX: --job-name=test_nf_exon
#FLUX: --urgency=16

export SINGULARITY_CACHEDIR='/scratch/mblab/edwardkang/singularity/cache'

eval $(spack load --sh singularityce@3.8.0)
export SINGULARITY_CACHEDIR="/scratch/mblab/edwardkang/singularity/cache"
eval $(spack load --sh nextflow@22.10.4)
nextflow run exonPipeline_array.nf -c conf/sampleData_array.config
