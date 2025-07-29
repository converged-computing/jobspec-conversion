#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/tudorelu/Genome_analysis_scripts/pipeline_scripts/repeat_pipeline_scripts/complete_repeat_pipe.sh
