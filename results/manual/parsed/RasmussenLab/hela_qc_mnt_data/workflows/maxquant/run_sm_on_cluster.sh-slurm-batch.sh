#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/RasmussenLab/hela_qc_mnt_data/workflows/maxquant/run_sm_on_cluster.sh
