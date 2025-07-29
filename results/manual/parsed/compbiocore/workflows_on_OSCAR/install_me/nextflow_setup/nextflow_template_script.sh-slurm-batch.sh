#!/bin/bash
#SBATCH --mail-user=enter_email_here@brown.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8g
#SBATCH --time=05:00:00

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
