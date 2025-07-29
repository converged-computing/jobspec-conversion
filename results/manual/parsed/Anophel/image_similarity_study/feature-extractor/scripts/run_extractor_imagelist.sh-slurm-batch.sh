#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/Anophel/image_similarity_study/feature-extractor/scripts/run_extractor_imagelist.sh
