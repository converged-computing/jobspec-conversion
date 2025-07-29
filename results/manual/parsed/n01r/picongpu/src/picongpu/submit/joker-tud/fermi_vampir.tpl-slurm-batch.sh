#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/n01r/picongpu/src/picongpu/submit/joker-tud/fermi_vampir.tpl
