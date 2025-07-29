#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/bsc-wdc/apps/java/kmeans/2_apps_psco/launch_kmeansDC.job
