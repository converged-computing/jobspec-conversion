#!/bin/bash
#FLUX: --job-name=peachy-chip-3631
#FLUX: --priority=16

nextflow='/home/sennis/nextflow'
cd /data/sennis/AML/scarches_nf
module load singularity
$nextflow run main.nf -profile singularity -with-trace trace.txt -with-dag flowchart.png
