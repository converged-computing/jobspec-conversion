#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/ICRAR/aws-chiles02/pipeline/dj-processing/batch_cluster_makepdf.sh
