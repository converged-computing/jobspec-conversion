#!/bin/bash
#FLUX: --job-name=NextflowQAPipeline
#FLUX: -c=48
#FLUX: --priority=16

module load java/8u131
module load intel/2017.1
module load R/3.6.1
cd /gpfs/projects/bsc83/Projects/Ebola/code/ebola/nextflow_pipelines/scripts/SC/
chmod a+x 02_correlation_cellcyle.R
./02_correlation_cellcyle.R
