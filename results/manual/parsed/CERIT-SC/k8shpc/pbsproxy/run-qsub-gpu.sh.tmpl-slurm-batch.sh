#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/CERIT-SC/k8shpc/pbsproxy/run-qsub-gpu.sh.tmpl
