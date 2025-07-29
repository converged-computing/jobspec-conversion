#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/zkstewart/Genome_analysis_scripts/pipeline_scripts/assembly_pipeline_scripts/canu_assembly.sh
