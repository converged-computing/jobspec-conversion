#!/bin/bash
#FLUX: --job-name=GSV
#FLUX: --queue=work
#FLUX: -t=36000
#FLUX: --urgency=16

module load singularity/3.8.6-nompi
module load nextflow/22.04.3
nextflow run main.nf --input samples.tsv --ref /path/to/reference/fasta -config config/setonix.config --annotsv Annotations_Human
