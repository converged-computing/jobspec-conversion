#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/NOAA-EMC/HRRR/sms/prep/jhrrr_prep_cloud_11.qsub
