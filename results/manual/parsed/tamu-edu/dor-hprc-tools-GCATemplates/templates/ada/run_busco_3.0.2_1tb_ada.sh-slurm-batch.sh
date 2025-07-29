#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/tamu-edu/dor-hprc-tools-GCATemplates/templates/ada/run_busco_3.0.2_1tb_ada.sh
