#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/zkstewart/Genome_analysis_scripts/gene_annotation_pipeline/gemoma/run_gemoma_pipe.sh
