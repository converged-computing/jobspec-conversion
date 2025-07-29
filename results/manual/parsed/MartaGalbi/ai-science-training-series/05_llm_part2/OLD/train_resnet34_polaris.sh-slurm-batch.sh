#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/MartaGalbi/ai-science-training-series/05_llm_part2/OLD/train_resnet34_polaris.sh
