#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/CodeLemon/picongpu/src/picongpu/submit/joker/fermi_vampir.tpl
