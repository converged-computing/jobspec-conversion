#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/Fettpet/picongpu/src/picongpu/submit/joker-tud/tesla_vampir.tpl
