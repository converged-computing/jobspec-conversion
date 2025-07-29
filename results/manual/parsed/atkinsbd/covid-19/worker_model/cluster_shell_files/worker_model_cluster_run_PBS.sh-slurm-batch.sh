#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/atkinsbd/covid-19/worker_model/cluster_shell_files/worker_model_cluster_run_PBS.sh
