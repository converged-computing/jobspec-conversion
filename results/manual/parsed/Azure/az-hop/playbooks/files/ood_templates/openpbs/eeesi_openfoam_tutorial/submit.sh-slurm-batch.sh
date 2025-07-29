#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/Azure/az-hop/playbooks/files/ood_templates/openpbs/eeesi_openfoam_tutorial/submit.sh
