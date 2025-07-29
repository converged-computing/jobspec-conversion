#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/AnjanaSenanayake/DeepSelectNet/tools/f5c/scripts/pipelines/methcall-ultra-pipeline.pbs.sh
