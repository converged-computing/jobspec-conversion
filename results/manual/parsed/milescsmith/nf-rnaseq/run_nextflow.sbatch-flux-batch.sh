#!/bin/bash
#FLUX: --job-name=cowy-cherry-0594
#FLUX: -c=16
#FLUX: --queue=serial
#FLUX: --priority=16

unset _JAVA_OPTIONS
nextflow main.nf -profile slurm \
    --project /s/guth-aci/novaseq/controls \
    --raw_fastqs /s/guth-aci/novaseq/controls/fastqs \
    --with-dag flowchart.pdf \
    --with-report narch_advanta.html \
    -resume
