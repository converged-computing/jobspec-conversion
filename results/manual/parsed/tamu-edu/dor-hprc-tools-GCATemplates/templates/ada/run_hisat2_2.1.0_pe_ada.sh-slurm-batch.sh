#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/tamu-edu/dor-hprc-tools-GCATemplates/templates/ada/run_hisat2_2.1.0_pe_ada.sh
