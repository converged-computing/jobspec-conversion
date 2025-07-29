#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/master-csmi/python_magnetsetup_v110/python_magnetsetup/templates/jobmanager/dahu.json
