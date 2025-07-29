#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/deephyper/bo-moo/multiobjective/jahs-cifar10/job_tpe.sh
