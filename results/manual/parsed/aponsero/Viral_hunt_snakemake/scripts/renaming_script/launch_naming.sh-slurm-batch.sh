#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/aponsero/Viral_hunt_snakemake/scripts/renaming_script/launch_naming.sh
