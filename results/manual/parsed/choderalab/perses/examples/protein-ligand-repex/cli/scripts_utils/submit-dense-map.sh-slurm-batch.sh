#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/choderalab/perses/examples/protein-ligand-repex/cli/scripts_utils/submit-dense-map.sh
