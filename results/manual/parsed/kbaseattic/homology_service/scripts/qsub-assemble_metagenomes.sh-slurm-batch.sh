#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/kbaseattic/homology_service/scripts/qsub-assemble_metagenomes.sh
