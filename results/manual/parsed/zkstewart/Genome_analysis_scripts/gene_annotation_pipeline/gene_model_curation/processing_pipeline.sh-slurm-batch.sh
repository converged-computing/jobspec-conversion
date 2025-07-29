#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/zkstewart/Genome_analysis_scripts/gene_annotation_pipeline/gene_model_curation/processing_pipeline.sh
