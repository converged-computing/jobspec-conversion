#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/brendanjohnharris/Criticality/PBS/Torque/PBS_create_time_series_data.sh
