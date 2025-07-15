#!/bin/bash
#FLUX: --job-name=swampy-punk-7856
#FLUX: -t=10200
#FLUX: --urgency=16

export NXF_OPTS='-Xms1g -Xmx4g'
export NXF_SINGULARITY_CACHEDIR='$PWD/sing-img'
export NXF_HOME='$PWD/home-nextflow'

ml Nextflow/22.10.1
ml FastQC/0.11.9-Java-11
export NXF_OPTS='-Xms1g -Xmx4g'
export NXF_SINGULARITY_CACHEDIR=$PWD/sing-img
export NXF_HOME=$PWD/home-nextflow
nextflow run nf-core/rnaseq \
    -profile singularity \
    --input design_test.csv \
    --genome 'TAIR10' \
    --max_cpus '14' \
    --max_memory '60GB' \
    --outdir $PWD \
    -resume
