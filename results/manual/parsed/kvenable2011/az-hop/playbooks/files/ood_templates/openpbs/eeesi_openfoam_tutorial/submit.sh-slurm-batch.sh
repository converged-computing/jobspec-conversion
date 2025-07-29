#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/kvenable2011/az-hop/playbooks/files/ood_templates/openpbs/eeesi_openfoam_tutorial/submit.sh
