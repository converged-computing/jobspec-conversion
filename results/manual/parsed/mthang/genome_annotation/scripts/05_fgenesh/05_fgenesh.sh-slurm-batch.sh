#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/mthang/genome_annotation/scripts/05_fgenesh/05_fgenesh.sh
