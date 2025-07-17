#!/bin/bash
#FLUX: --job-name=nf-scarches
#FLUX: -n=8
#FLUX: --queue=highmem
#FLUX: --urgency=16

nextflow='/home/sennis/nextflow'
cd /data/sennis/AML/scarches_nf
module load singularity
$nextflow run main.nf -profile singularity -with-trace trace.txt -with-dag flowchart.png
