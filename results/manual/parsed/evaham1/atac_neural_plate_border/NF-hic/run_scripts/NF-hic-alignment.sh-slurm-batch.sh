#!/bin/bash
#FLUX: --job-name=NF-hichip_alignment
#FLUX: -t=151200
#FLUX: --urgency=16

export TERM='xterm'
export NXF_VER='22.10.3'

export TERM=xterm
ml purge
ml Java/11.0.2
ml Nextflow/22.10.3
ml Singularity/3.6.4
export NXF_VER=22.10.3
nextflow pull nf-core/hic
nextflow run nf-core/hic \
    -r 2.0.0 \
    -c ./conf/crick_params.config \
    --digestion 'mboi' \
    --input  ./data/samplesheet.csv \
    --outdir ../output/NF-hichip_alignment \
    --email hamrude@crick.ac.uk \
    -resume
