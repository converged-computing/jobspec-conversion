#!/bin/bash
#FLUX: --job-name=buttery-car-3235
#FLUX: -t=18000
#FLUX: --priority=16

export SINGULARITY_CACHEDIR='$HOME/scratch'
export NXF_SINGULARITY_CACHEDIR='$HOME/scratch'

export SINGULARITY_CACHEDIR=$HOME/scratch
export NXF_SINGULARITY_CACHEDIR=$HOME/scratch
nextflow_start
nextflow run nf-core/<name_of_nf-core_pipeline_you_want> -profile singularity 
nextflow run nf-core/ampliseq -profile singularity 
nextflow run nextflow-io/<name_of_pipeline_you_want> 
nextflow run nextflow-io/rnatoy  
nextflow run <path_to_your_nextflow.nf_file_and_project_directory> 
nextflow run ${HOME}/nextflow_tutorial/tutorial.nf 
