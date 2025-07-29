#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/kyclark/metagenomics-book/hpc/pbs/job-array/ftp-get.sh
