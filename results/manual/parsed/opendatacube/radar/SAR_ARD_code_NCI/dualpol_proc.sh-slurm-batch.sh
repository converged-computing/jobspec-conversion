#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/opendatacube/radar/SAR_ARD_code_NCI/dualpol_proc.sh
