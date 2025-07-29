#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/janmandel/WRF-WindNinja-FarsiteScript/include/buildEverything_Aeolus.sh
