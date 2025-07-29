#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/skblnw/mkrun/NAMD/fep/template/mknamd_submit_alascan_cluster_sarscov2.sh
