#!/bin/bash
#FLUX: --job-name=PreprocessZyagen
#FLUX: -c=48
#FLUX: --priority=16

module load java/8u131
module load intel/2017.1
module load nextflow/19.03.0
module load singularity
nextflow run /gpfs/projects/bsc83/Projects/Ebola/code/ebola/nextflow_pipelines/01c_merge.nf \
                  -w /gpfs/projects/bsc83/Data/Ebola/work/ \
                  -c ../configs/nextflow.config.rnaseq
