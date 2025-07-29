#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/egor-dolzhenko/ehdn-paper-analysis/STR_Simulation/Deprecated/SimulateFastaDirectory_GRCh38_PBS.sh
