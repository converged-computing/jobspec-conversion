#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/dib-lab/2016-paper-p_asteroides/scripts/salmonQuant_SE.sh
