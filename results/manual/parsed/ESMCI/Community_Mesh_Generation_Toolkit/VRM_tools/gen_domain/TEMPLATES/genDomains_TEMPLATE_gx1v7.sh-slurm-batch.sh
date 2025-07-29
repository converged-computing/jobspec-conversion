#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/ESMCI/Community_Mesh_Generation_Toolkit/VRM_tools/gen_domain/TEMPLATES/genDomains_TEMPLATE_gx1v7.sh
