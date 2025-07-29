#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/PanDAWMS/harvester_configurations/OLCF_Summit_ML/harvester/scripts/ANALY_ORNL_Summit_make_container.lsf.template
