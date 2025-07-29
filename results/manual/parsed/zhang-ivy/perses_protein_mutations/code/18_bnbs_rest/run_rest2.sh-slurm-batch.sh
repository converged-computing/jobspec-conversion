#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/zhang-ivy/perses_protein_mutations/code/18_bnbs_rest/run_rest2.sh
