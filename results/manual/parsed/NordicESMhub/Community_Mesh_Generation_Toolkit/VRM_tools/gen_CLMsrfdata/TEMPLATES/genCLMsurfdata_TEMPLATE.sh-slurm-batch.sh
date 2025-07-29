#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/NordicESMhub/Community_Mesh_Generation_Toolkit/VRM_tools/gen_CLMsrfdata/TEMPLATES/genCLMsurfdata_TEMPLATE.sh
