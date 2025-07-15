#!/bin/bash
#FLUX: --job-name=exoseq_hawk
#FLUX: --urgency=16

module load nextflow/21.10.6
cd /scratch/c.c1845715/nextflow_cellranger/exoseq_hawk # Change User ID
nextflow run main.nf --genome mouse --input 'input/input.csv' -with-trace
